FROM nginx:alpine

# Installation des outils nécessaires
RUN apk add --no-cache openssl apache2-utils

# Création des répertoires
RUN mkdir -p /var/www/images /var/www/ignition /etc/nginx/auth

# Configuration Nginx
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Script d'initialisation pour créer les credentials
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Exposition du port
EXPOSE 80 443

# Point de montage pour les fichiers
VOLUME ["/var/www/images", "/var/www/ignition"]

# Initialisation et démarrage
CMD ["/init.sh"]