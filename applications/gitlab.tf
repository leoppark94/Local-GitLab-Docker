module "gitlab" {
  source                       = "./gitlab"
  gitlab_docker_registry_image = "gitlab/gitlab-ce:18.3.1-ce.0"
  # Change the path
  # You need to create `config`, `data`, `logs` folder under the `gitlab_home_path`
  gitlab_home_path             = "/home/leopark/Projects/Personal/Local-GitLab-Docker/gitlab_home"
}
