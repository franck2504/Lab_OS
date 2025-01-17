# Étape 1: Utiliser une image de base minimale (sans rien de préinstallé)
FROM alpine:latest

# Étape 2: Mettre à jour le système et installer Apache (httpd)
RUN apk update && \
    apk add --no-cache apache2 && \
    mkdir -p /run/apache2 /var/www/localhost/htdocs

# Étape 3: Créer un utilisateur non-root pour exécuter Apache
RUN adduser -D -H -u 1000 -s /bin/false apacheuser

# Étape 4: Créer un site web statique
#RUN echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /var/www/localhost/htdocs/index.html
COPY index.html /var/www/localhost/htdocs/

# Étape 5: Créer le répertoire des logs et définir les bonnes permissions
RUN mkdir -p /var/www/logs && \
    touch /var/www/logs/error.log && \
    chown -R apacheuser:apacheuser /var/www/logs && \
    chmod -R 755 /var/www/logs

# Étape 6: Configurer Apache pour utiliser le bon emplacement des logs et définir ServerName
RUN sed -i 's#^ErrorLog .*#ErrorLog /var/www/logs/error.log#' /etc/apache2/httpd.conf && \
    sed -i 's#^CustomLog .*#CustomLog /var/www/logs/access.log combined#' /etc/apache2/httpd.conf && \
    echo "ServerName localhost" >> /etc/apache2/httpd.conf

# Étape 7: Exposer le port 80 (port par défaut d'Apache)
EXPOSE 80

# Étape 8: Définir l'utilisateur non-root pour exécuter Apache
USER apacheuser

# Étape 9: Démarrer Apache en mode foreground
CMD ["httpd", "-D", "FOREGROUND"]

# Étape 10: Ajouter un label pour indiquer que c'est une application frontend
LABEL app="frontend"
# Utiliser Alpine Linux pour une image minimale
# FROM alpine:3.14

# # Définir des métadonnées
# LABEL maintainer="Nom Prénom <email@example.com>"
# LABEL description="Frontend application - Site web statique"

# # Installer Apache
# RUN apk add --no-cache apache2 && \
#     mkdir -p /run/apache2 /var/www/localhost/htdocs

# # Créer un utilisateur non-root
# RUN adduser -D -H -s /sbin/nologin webuser

# # Copier le contenu du site web
# #COPY index.html /var/www/localhost/htdocs/
# RUN echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /var/www/localhost/htdocs/index.html

# # Configurer Apache pour utiliser l'utilisateur non-root
# RUN sed -i 's/User apache/User webuser/' /etc/apache2/httpd.conf && \
#     sed -i 's/Group apache/Group webuser/' /etc/apache2/httpd.conf && \
#     echo "ServerName localhost" >> /etc/apache2/httpd.conf

# # Changer les permissions pour le répertoire du site
# RUN chown -R webuser:webuser /var/www

# # Exposer le port HTTP par défaut
# EXPOSE 80

# # Définir l'utilisateur non-root
# USER webuser

# # Commande pour démarrer Apache
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]
