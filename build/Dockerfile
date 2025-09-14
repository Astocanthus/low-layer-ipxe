FROM nginx:alpine

# Install necessary tools
RUN apk add --no-cache openssl apache2-utils

# Create directories
RUN mkdir -p /var/www/images /var/www/ignition /etc/nginx/auth

# Nginx configuration
COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf

# Initialization script to create credentials
COPY init.sh /init.sh
RUN chmod +x /init.sh

# Expose ports
EXPOSE 80 443

# Mount point for files
VOLUME ["/var/www/images", "/var/www/ignition"]

# Initialize and start
CMD ["/init.sh"]