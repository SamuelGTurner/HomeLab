# Helper Scripts

## WSL testing setup

### Setup WSL2 distribution

```ps
wsl --unregister DebianRPi
$rootFSDirectory = "C:\Program Files\WindowsApps\TheDebianProject.DebianGNULinux_1.20.0.0_x64__76v4gfsz19hv4"
wsl --import DebianRPi I:\WSL\DebianRPi ($rootFSDirectory+"\install.tar.gz")
wsl -d DebianRPi
```

### Add dev user
```sh
USERNAME=dev
sudo useradd -m -s /bin/bash "$USERNAME"
sudo passwd "$USERNAME"
sudo usermod -aG sudo "$USERNAME"
su - "$USERNAME"
```