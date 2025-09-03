resource "docker_image" "traefik" {
  name = var.traefik_docker_registry_image
}

# When default need resource
resource "docker_network" "this" {
  count  = var.network_name == "traefik" ? 1 : 0
  name   = var.network_name
  driver = "bridge"
}

locals {
  traefik_cmd = [
    "--providers.docker=true",
    "--entrypoints.web.address=:80",
    "--entrypoints.websecure.address=:443",
    "--providers.docker.exposedbydefault=false",
    "--api.dashboard=true",
    "--api.insecure=false",
    "--log.level=INFO",
    "--accesslog=true",
    "--metrics.prometheus=true",
    "--providers.docker.network=${var.network_name}"
  ]
}

# Create a container
resource "docker_container" "traefik" {
  image      = docker_image.traefik.image_id
  name       = var.traefik_container_name
  privileged = false
  restart = var.restart_container
  command    = local.traefik_cmd

  networks_advanced {
    name = var.network_name
  }

  volumes {
    host_path      = "/var/run/docker.sock"
    container_path = "/var/run/docker.sock"
    read_only      = true
  }

  ports {
    internal = 80
    external = var.http_port
    protocol = "tcp"
  }

  ports {
    internal = 443
    external = var.https_port
    protocol = "tcp"
  }

  labels {
    label = "traefik.enable"
    value = "true"
  }

  labels {
    label = "traefik.http.routers.dashboard.rule"
    value = "Host(`traefik.local.com`)"
  }

  labels {
    label = "traefik.http.routers.dashboard.entrypoints"
    value = "web"
  }

  labels {
    label = "traefik.http.routers.dashboard.service"
    value = "api@internal"
  }

}
