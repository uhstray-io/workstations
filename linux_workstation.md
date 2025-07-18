## Ubuntu 24.04 LTS Workstation Setup

This document outlines the steps to set up a development workstation on Ubuntu 24.04 LTS.

### Basic Resources

Install Brave Browser:

```bash
sudo snap install brave
```

Install Discord:

```bash
sudo snap install discord
```

### Developer Resources

Insert the line below into the .bashrc file

```bash
export PATH=$PATH:/home/username/.local/bin
```

Install VSCode:

```bash
sudo snap install code --classic
```

Install Git:

https://git-scm.com/book/en/v2/Getting-Started-First-Time-Git-Setup

```bash
sudo apt install git
```

Setup your git config:

```bash
git config --global user.name "MY_USER_NAME"
git config --global user.email myemail@email.com
```

Install Github Desktop

https://github.com/shiftkey/desktop?tab=readme-ov-file#installation-via-package-manager

```bash
wget -qO - https://apt.packages.shiftkey.dev/gpg.key | gpg --dearmor | sudo tee /usr/share/keyrings/shiftkey-packages.gpg > /dev/null
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/shiftkey-packages.gpg] https://apt.packages.shiftkey.dev/ubuntu/ any main" > /etc/apt/sources.list.d/shiftkey-packages.list'
```

```bash
sudo apt update && sudo apt install github-desktop
```

Install Python and Scikit-learn:

https://scikit-learn.org/stable/install.html

```bash
python3 --version
pip3 --verison
sudo apt install python3-pip
pip3 install scikit-learn
```

Edit the .bashrc file:

```bash
sudo nano ~/.bashrc
```

Install Docker and Docker Desktop:

```bash
sudo apt-get update
sudo apt-get install ca-certificates curl
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```

Install Docker Dependencies:
```bash
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
```

Initialize GPG Key:

```bash
gpg --generate-key
```

Copy the GPG key from the output to clipboard:

Initialize your GPG key.

```bash
pass init <my_key>
```

Download the Docker Desktop .deb file from the official website:

```bash
wget https://desktop.docker.com/linux/main/amd64/docker-desktop-amd64.deb
```

Install the downloaded .deb file:

```bash
sudo apt update
sudo apt install ./docker-desktop-amd64.deb
```

Install NixOS

Mulit-user install:
```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
```


NixOS Initial Multi-user Setup:

https://nix.dev/manual/nix/2.28/installation/multi-user


https://www.cyberciti.biz/faq/bash-for-loop/

Create 10 build users:
```bash
sudo for n in $(seq 1 10) 
do 
    useradd -c "Nix build user $n" \
    -d /var/empty -g nixbld -G nixbld -M -N -r -s "$(which nologin)" \
    nixbld$n 
done
```

Configuring NixOS machine for RustDesk Compatibility:

```bash
