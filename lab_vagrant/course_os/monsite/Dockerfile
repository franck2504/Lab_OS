FROM debian
RUN apt-get update \
&& apt-get install -y apache2
EXPOSE 80
WORKDIR /var/www/html
COPY index.html index.html
CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
