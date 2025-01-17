#!/usr/bin/env bash

# Fonction pour installer Docker sur Ubuntu/Debian
install_docker_ubuntu_debian() {
    # Mise à jour des paquets
    apt update
    
    # Suppression des anciennes versions de Docker
    apt remove -y docker docker-engine docker.io containerd runc
    
    # Installation des dépendances requises
    apt install -y apt-transport-https ca-certificates curl gnupg lsb-release
    
    # Ajout de la clé GPG officielle de Docker
    curl -fsSL https://download.docker.com/linux/$1/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    
    # Ajout du dépôt Docker officiel
    echo \
    "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/$1 \
    $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Mise à jour des sources après avoir ajouté le dépôt Docker
    apt update
    
    # Installation de Docker
    apt install -y docker-ce docker-ce-cli containerd.io
    
    # Vérification de l'installation de Docker
    docker --version
}

# Fonction pour installer Docker sur CentOS
install_docker_centos() {
    # Mise à jour des paquets
    yum update -y
    
    # Suppression des anciennes versions de Docker
    yum remove -y docker docker-client docker-client-latest docker-common docker-latest docker-latest-logrotate docker-logrotate docker-engine
    
    # Installation des dépendances requises
    yum install -y yum-utils device-mapper-persistent-data lvm2
    
    # Ajout du dépôt Docker officiel
    yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo
    
    # Installation de Docker
    yum install -y docker-ce docker-ce-cli containerd.io
    
    # Démarrage et activation de Docker
    systemctl start docker
    systemctl enable docker
    
    # Vérification de l'installation de Docker
    docker --version
}

# Détection de la distribution et appel de la fonction d'installation appropriée
if [ -f /etc/debian_version ]; then
    # Détection si Ubuntu ou Debian
    if [ -f /etc/lsb-release ]; then
        DISTRO="ubuntu"
    else
        DISTRO="debian"
    fi
    install_docker_ubuntu_debian $DISTRO
elif [ -f /etc/centos-release ]; then
    install_docker_centos
else
    echo "Système d'exploitation non supporté"
    exit 1
fi

# Test de Docker avec l'image hello-world
sudo docker run hello-world

# lancement d'un conteneur nginx 
sudo docker run -d -p 80:80 nginx
