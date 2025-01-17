#!/usr/bin/env bash

# Fonction pour installer Docker sur Ubuntu/Debian
install_docker_ubuntu_debian() {
    apt update
    apt remove -y docker docker-engine docker.io containerd runc
    apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
    curl -fsSL https://download.docker.com/linux/$1/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$1 $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    apt update
    apt install -y docker-ce docker-ce-cli containerd.io
}

# Fonction pour installer Docker sur Fedora
install_docker_fedora() {
    dnf -y install dnf-plugins-core
    dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
    dnf install -y docker-ce docker-ce-cli containerd.io
    systemctl start docker
    systemctl enable docker
}

# Fonction pour installer Docker sur Arch Linux
install_docker_arch() {
    pacman -Syu --noconfirm
    pacman -S --noconfirm docker
    systemctl start docker.service
    systemctl enable docker.service
}

# Détection de la distribution et appel de la fonction d'installation appropriée
if [ -f /etc/debian_version ]; then
    if [ -f /etc/lsb-release ]; then
        install_docker_ubuntu_debian ubuntu
    else
        install_docker_ubuntu_debian debian
    fi
elif [ -f /etc/fedora-release ]; then
    install_docker_fedora
elif [ -f /etc/arch-release ]; then
    install_docker_arch
else
    echo "Système d'exploitation non supporté"
    exit 1
fi

# Vérification de l'installation de Docker
docker --version

# Test de Docker avec l'image hello-world
docker run hello-world

# Lancement d'un conteneur nginx
docker run -d -p 80:80 nginx
