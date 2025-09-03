variable "lorry_registry_image" {
  description = "Container image to run lorry"
  type        = string
  default     = "registry.gitlab.com/codethinklabs/lorry/lorry2:2.7.0"
}

variable "lorry_container_name" {
  description = "The name of the container."
  type        = string
  default     = "local_lorry"
}

variable "lorry_port" {
  description = "port for lorry front"
  type        = number
  default     = 3000
}

variable "network_name" {
  description = "Docker Network Name"
  type        = string
  default     = "lorry"
}

variable "use_traefik" {
  description = "Use external loadbalancer(traefik)"
  type        = bool
  default     = false
}

variable "lorry_token_path" {
  description = "lorry downstream token path"
  type        = string
}

variable "lorry_home_path" {
  description = "Lorry Home Path"
  type        = string
  default     = "./lorry_home"
}

variable "gitlab_host_name" {
  description = "Host name of downstream gitlab"
  type = string
}

variable "restart_container" {
  description = "The restart policy for the container. Must be one of 'no', 'on-failure', 'always', 'unless-stopped'."
  type        = string
  default     = "unless-stopped"
}

variable "config_source_path" {
  description = "Optional config folder path to mount to /config_source"
  type        = string
  default     = ""
}
