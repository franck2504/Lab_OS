#!/usr/bin/env bash

# Mettre à jour la liste des paquets
sudo apt-get update

# Installer les dépendances nécessaires
sudo apt-get install -y software-properties-common

# Ajouter le dépôt officiel d'Ansible
sudo add-apt-repository --yes --update ppa:ansible/ansible

# Installer Ansible
sudo apt-get install -y ansible

# Vérifier que Ansible est bien installé
ansible --version
# apt update
# apt install -y apache2
# if ! [ -L /var/www ]; then
#     rm -rf /var/www
#     ln -fs /vagrant /var/www
# fi