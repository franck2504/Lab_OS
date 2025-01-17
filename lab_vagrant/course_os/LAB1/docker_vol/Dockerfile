# FROM nginx:alpine

# COPY index.html /usr/share/nginx/html/index.html

# EXPOSE 80

# FROM nginx:alpine

# # Copier le fichier index.html
# COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html

# # Modifier les permissions
# RUN chmod 755 /usr/share/nginx/html/index.html && \
#     chown -R nginx:nginx /var/cache/nginx && \
#     chown -R nginx:nginx /var/log/nginx && \
#     chown -R nginx:nginx /etc/nginx/conf.d && \
#     touch /var/run/nginx.pid && \
#     chown -R nginx:nginx /var/run/nginx.pid

# # Modifier la configuration Nginx pour utiliser un port non privilégié
# RUN sed -i 's/80/8080/g' /etc/nginx/conf.d/default.conf

# # Utiliser l'utilisateur nginx
# USER nginx

# EXPOSE 8080

# CMD ["nginx", "-g", "daemon off;"]

# Étape 1: Utiliser une image de base minimale (sans rien de préinstallé)
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
# COPY index.html /var/www/localhost/htdocs/

# RUN mkdir -p /var/www/logs && \
#     touch /var/www/logs/error.log && \
#     chown -R webuser:webuser /var/www/logs && \
#     chmod -R 755 /var/www/logs

# RUN sed -i 's#^ErrorLog .*#ErrorLog /var/www/logs/error.log#' /etc/apache2/httpd.conf && \
#     sed -i 's#^CustomLog .*#CustomLog /var/www/logs/access.log combined#' /etc/apache2/httpd.conf

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

# Étape 1: Utiliser une image de base minimale
# FROM alpine:3.14

# # Étape 2: Définir des métadonnées
# LABEL maintainer="Nom Prénom <email@example.com>"
# LABEL description="Frontend application - Site web statique"

# # Étape 3: Installer Apache
# RUN apk add --no-cache apache2 && \
#     mkdir -p /run/apache2 /var/www/localhost/htdocs /var/www/logs && \
#     echo "<html><body><h1>Bienvenue sur le site de Nom Prénom</h1></body></html>" > /var/www/localhost/htdocs/index.html && \
#     touch /var/www/logs/error.log /var/www/logs/access.log && \
#     chown -R apache:apache /var/www && \
#     chmod -R 755 /var/www

# # Étape 4: Configurer Apache
# RUN echo "ServerName localhost" >> /etc/apache2/httpd.conf

# # Étape 5: Exposer le port 80
# EXPOSE 80

# # Étape 6: Définir l'utilisateur non-root pour exécuter Apache
# #USER apache

# # Étape 7: Commande pour démarrer Apache
# CMD ["/usr/sbin/httpd", "-D", "FOREGROUND"]


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


