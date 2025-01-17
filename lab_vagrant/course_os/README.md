# Course_OS

# Docker images exercice guidé

# cette commande construire un container avec le nom 'imageperso' en mode interactive avec une image alpine et ouvre un shell absh
sudo docker container run -it -name imageperso alpine /bin/sh 
# une fois démarré, on pourra effectuer des modifications comme une mise à jour des paquets
apk update & apk add iputils
# la commande suivante liste tout les containers présent et filtre cela pour n'afficher que ceux avec le nom perso
sudo docker container ls -a | grep perso
# cette commande crée une nouvelle image monimageperso à partir du dernier commit du container imageperso
sudo docker container commit imageperso monimageperso
# cette commande liste les images 
sudo docker image ls


### Docker File 
  # construire l'image avec le nom centoswget à partir du Dockerfile 
  sudo docker image build -t centoswget .
  
  # crée l'image wwwimageperso
  sudo docker image build -t wwwimageperso .
  # exécute le container à partir de l'image en redirigeant le port 5000 vers le port 80 du conteneur.
  sudo docker container run -d -name WWW -p 5000:80 wimageperso
  # tester 
  w3m http /127.0.0.1:5000/


### Images Multi-stages
    sudo docker image build -t hello-small .
    sudo docker image ls | grep hello


## LAB1 
  ## CONTENEUR
    # docker build -t image_NomPrenom .
    # docker volume create volume_NomPrenom
    # docker run -d --name conteneur_NomPrenom -p 8080:80 -v volume_NomPrenom:/mon_volume image_NomPrenom
