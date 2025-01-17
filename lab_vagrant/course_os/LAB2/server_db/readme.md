# 1 creer un volume 
docker volume create volume_DB
# 2 construire l'image 
docker build -t image_DB .
# 3 creer un reseau 
docker network create \
  --driver bridge \
  --subnet=192.168.1.0/24 \
  --gateway=192.168.1.254 \
  --ip-range=192.168.1.1/28 \
  net_NomPrenom
# 4 demarrer le conteneur de la BD 
docker run -d \
  --name db_container \
  --network net_NomPrenom \
  --ip 192.168.1.2 \
  -v volume_DB:/var/lib/mysql \
  -e MYSQL_ROOT_PASSWORD=root \
  -e MYSQL_DATABASE=demoDB \
  -e MYSQL_USER=user \
  -e MYSQL_PASSWORD=password \
  image_DB


# 5 creer l'image pour le client 
docker build -t image_SQLClient .
# 6 demarrer le client 

docker run -it \
  --name sql_client \
  --network net_NomPrenom \
  --ip 192.168.1.3 \
  image_SQLClient \
  mysql -h db_container -u user -ppassword demoDB


# Résultat attendu
Le conteneur db_container contient la base de données demoDB avec une table employees pré-remplie.
Le conteneur sql_client peut interagir avec db_container via le réseau net_NomPrenom.
Vous pouvez exécuter des requêtes SQL dans le client pour interroger ou modifier la base de données, par exemple :

SELECT * FROM employees;