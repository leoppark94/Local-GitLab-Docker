# Pulls the image
resource "docker_image" "lorry" {
  name = var.lorry_registry_image
}

locals {
  lorry_ports = [
    {
      internal = 3000
      external = var.lorry_port
      protocol = "tcp"
    },
  ]
}

# When default need resource
resource "docker_network" "this" {
  count  = var.network_name == "lorry" ? 1 : 0
  name   = var.network_name
  driver = "bridge"
}

# Create lorry config file
locals {
  lorry_config = templatefile("${path.module}/template/lorry.conf.tpl", {
    hostname = var.gitlab_host_name
  })
}

resource "local_file" "lorry_config" {
  filename = "${path.module}/generated/lorry.conf"
  content  = local.lorry_config
}

locals {
  default_lorry_file = {
    host_path      = abspath("${path.module}/template/lorry.yaml")
    container_path = "/config_source/lorry.yaml"
  }
  default_lorry_controller_conf = {
    host_path      = abspath("${path.module}/template/lorry-controller.conf")
    container_path = "/config_source/lorry-controller.conf"
  }
}

locals {
  lorry_files_directory = {
    host_path      = abspath(var.config_source_path)
    container_path = "/config_source"
  }
}

resource "docker_container" "lorry" {
  image      = docker_image.lorry.image_id
  name       = var.lorry_container_name
  hostname   = "lorry.local.com"
  restart    = var.restart_container
  depends_on = [local_file.lorry_config]
  privileged = false

  networks_advanced {
    name = var.network_name
  }

  dynamic "ports" {
    for_each = var.use_traefik ? [] : local.lorry_ports
    content {
      internal = ports.value.internal
      external = ports.value.external
      protocol = ports.value.protocol
    }
  }
  # Mount Lorry configurations
  volumes {
    host_path      = "${var.lorry_home_path}/workd"
    container_path = "/workd"
  }

  volumes {
    host_path      = abspath(local_file.lorry_config.filename)
    container_path = "/config/lorry.conf"
    read_only      = true
  }

  volumes {
    host_path      = "${var.lorry_home_path}/db"
    container_path = "/db"
  }



  dynamic "volumes" {
    for_each = var.config_source_path == "" ? [local.default_lorry_file, local.default_lorry_controller_conf]:[local.lorry_files_directory]
    content {
      host_path      = volumes.value.host_path
      container_path = volumes.value.container_path
    }
  }

  volumes {
    host_path      = abspath(var.lorry_token_path)
    container_path = "/lorry_auth/lorry.token"
  }

  # traefik settings
  labels {
    label = "traefik.enable"
    value = "true"
  }

  labels {
    label = "traefik.http.routers.lorry.rule"
    value = "Host(`lorry.local.com`)"
  }

  labels {
    label = "traefik.http.routers.lorry.entrypoints"
    value = "web"
  }

  labels {
    label = "traefik.http.services.lorry.loadbalancer.server.port"
    value = "3000"
  }
}
