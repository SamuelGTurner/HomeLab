# HomeLab


## Setup


### Container Manangement
[Portainer-CE](https://docs.portainer.io/start/install-ce) behind a [Traefik](https://doc.traefik.io/traefik/getting-started/install-traefik/) reverse proxy with a [Docker](https://docs.docker.com/get-started/) socket proxy by [linuxserver](https://docs.linuxserver.io/images/docker-socket-proxy/). 

#### Portainer Host
```sh
sudo apt update && sudo apt install curl -y

sudo bash -c "$(curl -s https://raw.githubusercontent.com/SamuelGTurner/HomeLab/refs/heads/main/container-management/portainer-host/deploy.sh) _ -p"

```

#### Portainer Agent
```sh
sudo apt update && sudo apt install curl -y

sudo bash -c "$(curl -s https://raw.githubusercontent.com/SamuelGTurner/HomeLab/refs/heads/main/container-management/portainer-agent/deploy.sh) _ -p"

```

## Docs
https://docs.docker.com/reference/compose-file/
https://github.com/anandslab/docker-traefik
https://doc.traefik.io/traefik/reference/install-configuration/providers/docker/
https://docs.docker.com/engine/install/debian/#install-using-the-repository
https://docs.portainer.io/start/upgrade/docker
