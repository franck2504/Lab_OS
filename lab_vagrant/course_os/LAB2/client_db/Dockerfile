# Base image
FROM mysql:8.0

# Maintainer information
LABEL maintainer="Nom Prénom"

# Install necessary tools
RUN apt-get update && apt-get install -y \
    netcat \
    && rm -rf /var/lib/apt/lists/*

# Default command for interactive MySQL client
CMD ["mysql"]
