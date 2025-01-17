#!/usr/bin/env bash

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
minikubeinstall
kubectlinstall
autocompletioninstall
othersoftwareinstall