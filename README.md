# Local-GitLab-Docker
Provisioning GitLab using Terraform, Docker, and Traefik reverse proxy

## Architecture

This project uses a modular Terraform approach to deploy:
- **GitLab CE** - Git repository management and CI/CD
- **Traefik** - Reverse proxy and load balancer with automatic service discovery
- **Docker Network** - Isolated network for container communication

## Prerequisites

- Docker and Docker Compose
- Terraform(or OpenTofu)

## Quick Start

### 1. Deploy the Infrastructure

```shell
terraform init
terraform plan
terraform apply
```

### 2. Configure Local DNS
Add the following lines to your `/etc/hosts` file:

```text
127.0.0.1 gitlab.local.com
127.0.0.1 traefik.local.com
127.0.0.1 lorry.local.com
```

#### GitLab
- **URL**: http://gitlab.local.com
- **Username**: `root`
- **Initial Password**: Run the following command to retrieve it:

```shell
docker exec -it <gitlab_container_name> grep 'Password:' /etc/gitlab/initial_root_password
```

> Change the Password after first access.
> The file will be deleted automatically

#### Traefik Dashboard
- **URL**: http://traefik.local.com
- Monitor routing rules, services, and health status

#### Traefik Dashboard
- **URL**: http://lorry.local.com
- Monitor lorry2 status

### 3. Create Account for lorry

- Create Account on the `gitlab.local.com`
- Access with that account and create token for lorry(need api and read/write repositories permission)
- Create `lorry.token` file under `/application`
```shell
cd application
$EDITOR lorry.token
```

Paste the generated token
