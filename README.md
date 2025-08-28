# Local-GitLab-Docker
Provisioning GitLab using terraform and docker

### Add line on '/etc/hosts'
Add following line:
`127.0.0.1 gitlab.localdomain.com`

### root password
to know the root password:
`sudo docker exec -it local_gitlab grep 'Password:' /etc/gitlab/initial_root_password`
