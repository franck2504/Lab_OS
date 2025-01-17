# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
RAM= 2028
CPU = 2

Vagrant.configure("2") do |config|

  config.vm.define "debian" do |debian|
    debian.vm.box = "debian/bullseye64"
    debian.vm.hostname = "ubuntu-vm"
    debian.vm.synced_folder "./data_file", "/home/vagrant/data_file"
    debian.vm.provision :shell, path: "install_docker.sh"
    debian.vm.network "private_network" , ip: "192.168.33.10"
    debian.vm.network "forwarded_port" , guest: 8000, host: 5000
    debian.vm.provision "shell", inline: <<-SHELL
       echo 'vagrant ALL=(ALL) NOPASSWD:ALL'| sudo tee -a /etc/sudoers
    SHELL
    debian.vm.provider "virtualbox" do |vb|
     
      vb.memory=RAM
      vb.cpus=CPU
    end
  end

  config.vm.define "ubuntu" do |ubuntu|
    ubuntu.vm.box = "ubuntu/focal64"
    ubuntu.vm.hostname = "ubuntu-vm"
    ubuntu.vm.synced_folder "./data_file", "/home/vagrant/data_file"
    ubuntu.vm.provision :shell, path: "install_docker.sh"
    ubuntu.vm.network "private_network" , ip: "192.168.33.12"
    ubuntu.vm.network "forwarded_port" , guest: 8080, host: 5051, host_IP: "127.0.0.1"
    ubuntu.vm.provision "shell", inline: <<-SHELL
      echo 'vagrant ALL=(ALL) NOPASSWD:ALL'| sudo tee -a /etc/sudoers
    SHELL
    ubuntu.vm.provider "virtualbox" do |vb|
  
      vb.memory=RAM
      vb.cpus=CPU
    end
  end

  config.vm.define "fedora" do |fedora|
    fedora.vm.box = "generic/fedora34"
    fedora.vm.hostname = "fedora-vm"
    fedora.vm.synced_folder "./data_file", "/home/vagrant/data_file"
    fedora.vm.provision :shell, path: "install_docker.sh"
    fedora.vm.network "private_network" , ip: "192.168.33.13"
    #fedora.vm.network "forwarded_port" , guest: 80, host: 5050, host_IP: "127.0.0.1"
    fedora.vm.provision "shell", inline: <<-SHELL
      echo 'vagrant ALL=(ALL) NOPASSWD:ALL'| sudo tee -a /etc/sudoers
    SHELL
    fedora.vm.provider "virtualbox" do |vb|
  
      vb.memory=RAM
      vb.cpus=CPU
    end
  end

end
