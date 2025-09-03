output "ip" {
  description = "Docker IP Address of GitLab"
  value = docker_container.gitlab.network_data.0.ip_address
}
