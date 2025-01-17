# # Utiliser une image de base légère
# FROM alpine:3.14

# # Définir des métadonnées
# LABEL maintainer="Nom Prénom <email@example.com>"
# LABEL description="Frontend application - Site web statique"

# # Installer Apache et les dépendances nécessaires
# RUN apk add --no-cache apache2 && \
#     mkdir -p /run/apache2 /var/www/logs && \
#     touch /var/www/logs/error.log

# # Configurer Apache pour éviter les messages d'avertissement
# RUN sed -i 's/#LoadModule unixd_module/LoadModule unixd_module/' /etc/apache2/httpd.conf && \
#     echo "ServerName localhost" >> /etc/apache2/httpd.conf

# # Copier le contenu du site web
# COPY index.html /var/www/localhost/htdocs/

# # Changer les permissions si nécessaire (reste root ici)
# RUN chmod -R 755 /var/www

# # Exposer le port 80
# EXPOSE 80

# # Utiliser l'utilisateur root (par défaut)
# # Pas besoin d’ajouter USER root, car root est l'utilisateur par défaut

# # Commande pour démarrer Apache en premier plan
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]

# FROM debian:bullseye-slim

# #Metadonnées
# LABEL app="frontend"

# #Installation d'Apache et nettoyage
# RUN apt-get update && \
#     apt-get install -y apache2 && \
#     rm -rf /var/lib/apt/lists/*

# #Création d'un utilisateur non-root
# RUN groupadd -r appgroup && useradd --no-log-init -r -g appgroup appuser

# #Configuration d'Apache pour l'utilisateur non-root
# RUN sed -i 's/^User ${APACHE_RUN_USER}/User appuser/' /etc/apache2/apache2.conf && \
#     sed -i 's/^Group ${APACHE_RUN_GROUP}/Group appgroup/' /etc/apache2/apache2.conf && \
#     chown -R appuser:appgroup /var/www/html && \
#     chown -R appuser:appgroup /var/log/apache2 && \
#     mkdir -p /var/run/apache2 && \
#     chown -R appuser:appgroup /var/run/apache2 && \
#     mkdir -p /var/lock/apache2 && \
#     chown -R appuser:appgroup /var/lock/apache2

# #Création du contenu du site web (tu peux  remplacer par   un fichier index.html)
# RUN echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /var/www/html/index.html

# #Changement des permissions du fichier
# RUN chown appuser:appgroup /var/www/html/index.html

# #Exposition du port 80
# EXPOSE 80

# #Changement vers l'utilisateur non-root
# USER appuser

# #Démarrage d'Apache
# CMD ["apache2ctl", "-D", "FOREGROUND"]



FROM httpd:2.4

# Créer un utilisateur non-root
RUN groupadd -r appgroup && useradd --no-log-init -r -g appgroup appuser

# Copier la configuration Apache personnalisée si nécessaire
# COPY ./my-httpd.conf /usr/local/apache2/conf/httpd.conf

# Modifier les permissions des répertoires nécessaires
RUN chown -R appuser:appgroup /usr/local/apache2/htdocs/ && \
    chmod -R 755 /usr/local/apache2/htdocs/ && \
    chown -R appuser:appgroup /usr/local/apache2/logs/ && \
    chmod -R 755 /usr/local/apache2/logs/

# Copier le contenu de votre site web
RUN echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /usr/local/apache2/htdocs/index.html 
    
RUN chown -R appuser:appgroup /usr/local/apache2/htdocs/

# Modifier la configuration pour utiliser des répertoires accessibles en écriture par l'utilisateur non-root
# RUN sed -i \
#     -e 's|^PidFile .*|PidFile /tmp/httpd.pid|' \
#     -e 's|^ErrorLog .*|ErrorLog /tmp/error.log|' \
#     /usr/local/apache2/conf/httpd.conf

# Passer à l'utilisateur non-root
USER appuser

EXPOSE 80

CMD ["httpd-foreground"]