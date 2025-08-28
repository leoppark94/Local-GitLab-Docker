# Pulls the image
resource "docker_image" "gitlab" {
  name = var.gitlab_docker_registry_image
}

# Create a container
resource "docker_container" "gitlab" {
  image    = docker_image.gitlab.image_id
  name     = var.gitlab_container_name
  hostname = "gitlab.localdomain.com"
  env = [
    "external_url 'https://gitlab.localdomain.com'"
  ]

  # HTTP
  ports {
    internal = 80
    external = var.http_port
    protocol = "tcp"
  }

  # HTTPS
  ports {
    internal = 443
    external = var.https_port
    protocol = "tcp"
  }

  # SSH
  ports {
    internal = 22
    external = var.ssh_port
    protocol = "tcp"
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
