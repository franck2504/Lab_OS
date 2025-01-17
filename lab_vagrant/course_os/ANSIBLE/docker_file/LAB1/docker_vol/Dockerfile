# FROM nginx:alpine

# COPY index.html /usr/share/nginx/html/index.html

# EXPOSE 80

FROM nginx:alpine

# Copier le fichier index.html
COPY --chown=nginx:nginx index.html /usr/share/nginx/html/index.html

# Modifier les permissions
RUN chmod 755 /usr/share/nginx/html/index.html && \
    chown -R nginx:nginx /var/cache/nginx && \
    chown -R nginx:nginx /var/log/nginx && \
    chown -R nginx:nginx /etc/nginx/conf.d && \
    touch /var/run/nginx.pid && \
    chown -R nginx:nginx /var/run/nginx.pid

# Modifier la configuration Nginx pour utiliser un port non privilégié
RUN sed -i 's/80/8080/g' /etc/nginx/conf.d/default.conf

# Utiliser l'utilisateur nginx
USER nginx

EXPOSE 8080

CMD ["nginx", "-g", "daemon off;"]
