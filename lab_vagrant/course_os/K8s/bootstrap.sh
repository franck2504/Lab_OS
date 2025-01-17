#!/usr/bin/env bash

# Ensure the script is run with sudo
if [ "$EUID" -ne 0 ]; then
  echo "Please run as root"
  exit
fi

# Function to install Docker on Ubuntu/Debian
install_docker_ubuntu_debian() {
    # Update packages
    apt update || { echo "Failed to update packages"; exit 1; }
    
    # Remove old versions of Docker if they exist
    apt remove -y docker docker-engine docker.io containerd runc || true
    
    # Install required dependencies
    apt install -y apt-transport-https ca-certificates curl gnupg lsb-release || { echo "Failed to install dependencies"; exit 1; }
    
    # Add Docker's official GPG key
    curl -fsSL https://download.docker.com/linux/debian/gpg | gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg || { echo "Failed to add GPG key"; exit 1; }
    
    # Add Docker's official repository
    echo "deb [arch=amd64 signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/debian $(lsb_release -cs) stable" | tee /etc/apt/sources.list.d/docker.list > /dev/null
    
    # Update package index again after adding Docker repository
    apt update || { echo "Failed to update packages after adding Docker repository"; exit 1; }
    
    # Install Docker Engine, CLI, and containerd
    apt install -y docker-ce docker-ce-cli containerd.io || { echo "Failed to install Docker"; exit 1; }
    
    # Verify installation of Docker
    docker --version || { echo "Docker installation failed"; exit 1; }
}


minikubeinstall() {
    echo *******************************************************************
    echo Installing Minikube
    echo ******************************************************************
    # Fixed the URL by replacing "https" with "https://"
    sudo curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
    sudo install minikube-linux-amd64 /usr/local/bin/minikube
}

kubectlinstall() {
    echo *******************************************************************
    echo Installing kubectl
    echo ******************************************************************
    sudo apt-get install -y ca-certificates curl
    # Fixed the URL by replacing "https" with "https://"
    sudo curl -fsSL https://pkgs.k8s.io/core/stable/v1.28/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
    echo 'deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core/stable/v1.28/deb/' | sudo tee /etc/apt/sources.list.d/kubernetes.list
    sudo apt-get update
    sudo apt-get install -y kubectl

    echo ***************** Adding user to the docker group **************
    sudo usermod -aG docker $USER && newgrp docker  # Changed '&' to '&&'
}

autocompletioninstall() {
    echo *******************************************************************
    echo Configuring auto-completion
    echo ******************************************************************
    sudo apt install -y bash-completion
    source /usr/share/bash-completion/bash_completion
    kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null
}

othersoftwareinstall() {
    sudo apt-get install -y w3m
}

# Call functions in order
install_docker_ubuntu_debian
minikubeinstall
kubectlinstall
autocompletioninstall
othersoftwareinstall

echo "Installation complete!"