# This main.tf file is an example file and can be modified for use as needed.

resource "docker_network" "proxy" {
  name   = "proxy"
  driver = "bridge"
}

module "gitlab" {
  source                       = "./gitlab"
  gitlab_docker_registry_image = "gitlab/gitlab-ce:18.3.1-ce.0"
  # Change the path
  # You need to create `config`, `data`, `logs` folder under the `gitlab_home_path`
  gitlab_home_path = "/home/leopark/Projects/Personal/Local-GitLab-Docker/gitlab_home"
  use_traefik      = true
  network_name     = docker_network.proxy.name
}

module "traefik" {
  source       = "./traefik"
  network_name = docker_network.proxy.name
}

module "lorry" {
  source       = "./lorry2"
  depends_on = [module.gitlab]
  network_name = docker_network.proxy.name
  gitlab_host_name = module.gitlab.ip

  lorry_home_path  = "/home/leopark/Projects/Personal/Local-GitLab-Docker/lorry_home"
  lorry_token_path = "lorry.token"
}
