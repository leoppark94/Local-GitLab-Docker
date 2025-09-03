# Pulls the image
resource "docker_image" "gitlab" {
  name = var.gitlab_docker_registry_image
}

# When default need resource
resource "docker_network" "this" {
  count  = var.network_name == "gitlab" ? 1 : 0
  name   = var.network_name
  driver = "bridge"
}

locals {
  gitlab_ports = [
    {
      internal = 80
      external = var.http_port
      protocol = "tcp"
    },
    {
      internal = 443
      external = var.https_port
      protocol = "tcp"
    }
  ]
}

# Create a container
resource "docker_container" "gitlab" {
  image      = docker_image.gitlab.image_id
  name       = var.gitlab_container_name
  restart = var.restart_container
  privileged = false

  env = [
    "GITLAB_OMNIBUS_CONFIG=external_url 'http://gitlab.local.com'"
  ]

  networks_advanced {
    name = var.network_name
  }

  labels {
    label = "traefik.enable"
    value = "true"
  }

  labels {
    label = "traefik.http.routers.gitlab.rule"
    value = "Host(`gitlab.local.com`)"
  }

  labels {
    label = "traefik.http.routers.gitlab.entrypoints"
    value = "web"
  }

  labels {
    label = "traefik.http.services.gitlab.loadbalancer.server.port"
    value = "80"
  }

  dynamic "ports" {
    for_each = var.use_traefik ? [] : local.gitlab_ports
    content {
      internal = ports.value.internal
      external = ports.value.external
      protocol = ports.value.protocol
    }
  }

  # Stores the GitLab configuration files.
  # Container location: '/etc/gitlab'
  volumes {
    host_path      = "${var.gitlab_home_path}/config"
    container_path = "/etc/gitlab"
  }

  # Stores logs.
  # Container location: '/var/log/gitlab'
  volumes {
    host_path      = "${var.gitlab_home_path}/logs"
    container_path = "/var/log/gitlab"
  }

  # Stores application data.
  # Container location: '/var/opt/gitlab'
  volumes {
    host_path      = "${var.gitlab_home_path}/data"
    container_path = "/var/opt/gitlab"
  }

  shm_size = 256
}
