# Base image
FROM mariadb:10.5

# Maintainer information
LABEL maintainer="Nom Prénom"

# Set root password and database name as environment variables
ENV MYSQL_ROOT_PASSWORD=root
ENV MYSQL_DATABASE=demoDB
ENV MYSQL_USER=user
ENV MYSQL_PASSWORD=password

# Expose the default MySQL port
EXPOSE 3306

# Volume for database files
VOLUME ["/var/lib/mysql"]

# Copy initialization script to create initial data
COPY init.sql /docker-entrypoint-initdb.d/

# Start the database service
CMD ["mysqld"]
