variable "gitlab_docker_registry_image" {
  description = "Container image to run gitlab"
  type        = string
  default     = "gitlab/gitlab-ce:nightly"
}

variable "gitlab_container_name" {
  description = "The name of the container."
  type        = string
  default     = "local_gitlab"
}

variable "http_port" {
  description = "HTTP port to expose"
  type        = number
  default     = 80
}

variable "https_port" {
  description = "HTTPS port to expose"
  type        = number
  default     = 443
}

variable "ssh_port" {
  description = "SSH port to expose"
  type        = number
  default     = 22
}

variable "use_traefik" {
  description = "Use external loadbalancer(traefik)"
  type        = bool
  default     = false
}

variable "gitlab_home_path" {
  description = "GitLab Home Path"
  type        = string
  default     = "./gitlab_home"
}

variable "network_name" {
  description = "Docker Network Name"
  type        = string
  default     = "gitlab"
}

variable "restart_container" {
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'."
  type        = string
  default     = "unless-stopped"
}
