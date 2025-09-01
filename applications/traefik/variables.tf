variable "traefik_docker_registry_image" {
  description = "Container image to run traefik"
  type        = string
  default     = "traefik:v3.5"
}

variable "traefik_container_name" {
  description = "The name of the container."
  type        = string
  default     = "local_traefik"
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

variable "network_name" {
  description = "Docker Network Name"
  type        = string
  default     = "traefik"
}
