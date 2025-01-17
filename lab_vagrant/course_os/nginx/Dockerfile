# Étape 1: Utiliser une image de base légère pour la construction
FROM alpine:3.14 AS build

# Installer les dépendances nécessaires pour compiler Nginx
RUN apk add --no-cache build-base pcre-dev zlib-dev openssl-dev git

# Cloner le dépôt Nginx
RUN git clone --depth 1 https://github.com/nginx/nginx.git /nginx

# Compiler Nginx avec les modules nécessaires
WORKDIR /nginx
RUN ./auto/configure \
    --prefix=/usr/local/nginx \
    --with-http_ssl_module \
    --with-http_v2_module \
    --with-http_gzip_static_module && \
    make && make install 

# Étape 2: Créer une image minimale pour exécuter le serveur
FROM alpine:3.14

RUN apk add --no-cache pcre zlib openssl

# Copier les fichiers compilés depuis l'étape précédente
COPY --from=build /usr/local/nginx /usr/local/nginx

# Ajouter un fichier HTML statique (modifiez selon vos besoins)
RUN mkdir -p /usr/local/nginx/html && \
    echo "<html><body><h1>Bienvenue sur mon serveur web optimisé</h1></body></html>" > /usr/local/nginx/html/index.html

# Ajouter une configuration de base pour Nginx
RUN mkdir -p /usr/local/nginx/conf && \
    echo "events {} http { server { listen 80; location / { root /usr/local/nginx/html; index index.html; } } }" > /usr/local/nginx/conf/nginx.conf

# Définir le port d'écoute
EXPOSE 80

# Commande par défaut pour démarrer le serveur
CMD ["/usr/local/nginx/sbin/nginx", "-g", "daemon off;"]
