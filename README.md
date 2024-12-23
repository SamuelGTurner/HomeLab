# HomeLab

https://docs.docker.com/reference/compose-file/
https://github.com/anandslab/docker-traefik
https://doc.traefik.io/traefik/reference/install-configuration/providers/docker/


# Setup
https://docs.docker.com/engine/install/debian/#install-using-the-repository
https://docs.portainer.io/start/upgrade/docker

```docker run -d -p 8000:8000 -p 9443:9443 -p 9000:9000 --name=portainer --restart=unless-stopped -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data portainer/portainer-ce:2.21.5```


# Install

git clone https://github.com/SamuelGTurner/HomeLab.git
mkdir HomeLab/appdata HomeLab/secrets
cp HomeLab/artemis/.env.example HomeLab/artemis/.env
nano HomeLab/artemis/.env