variable "gitlab_docker_registry_image" {
  description = "The image ID or Image to use for gitlab image"
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

variable "gitlab_home_path" {
  description = "GitLab Home Path"
  type = string
  default = "./gitlab_home"
}
