# Setup

## Remote

```sh
# add ansible user and grant sudo
sudo adduser ansible
sudo adduser ansible sudo

# enable public key auth
sudo nano /etc/ssh/sshd_config
sudo systemctl restart ssh
```

## Ansible Host

```sh
# copy ansible.pub key to samue@remote
ssh-copy-id -f -i ~/.ssh/ansible.pub -o 'IdentityFile ~/.ssh/id_rsa' samue@192.168.0.100
```

## Remote

```sh
# copy authorised keys to ansible user
sudo cp -R /home/samue/.ssh/ /home/ansible/
sudo chown -R ansible:ansible /home/ansible/

# remove ansible key from samue
nano /home/samue/.ssh/authorized_keys
```

# Run playbook

```sh
ansible-playbook --ask-become-pass  playbooks/upgrade.yml
```
