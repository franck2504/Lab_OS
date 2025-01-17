# Utiliser une image de base légère
FROM alpine:3.14

# Définir des métadonnées
LABEL maintainer="Nom Prénom <email@example.com>"
LABEL description="Frontend application - Site web statique"

# Installer Apache et les dépendances nécessaires
RUN apk add --no-cache apache2 && \
    mkdir -p /run/apache2

# Créer un utilisateur non-root
RUN adduser -D -H -s /sbin/nologin webuser

# Configurer Apache pour utiliser l'utilisateur non-root
RUN sed -i 's/#LoadModule unixd_module/LoadModule unixd_module/' /etc/apache2/httpd.conf && \
    sed -i 's/User apache/User webuser/' /etc/apache2/httpd.conf && \
    sed -i 's/Group apache/Group webuser/' /etc/apache2/httpd.conf

# Copier le contenu du site web
COPY index.html /var/www/localhost/htdocs/

# Changer les permissions
RUN chown -R webuser:webuser /var/www/localhost/htdocs

# Exposer le port 80
EXPOSE 80

# Définir l'utilisateur non-root
USER webuser

# Commande pour démarrer Apache en premier plan
CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]