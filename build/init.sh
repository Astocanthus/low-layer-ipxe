#!/bin/sh

# Default environment variables
IPXE_USER=${IPXE_USER:-admin}
IPXE_PASSWORD=${IPXE_PASSWORD:-changeme}

# Create password file if it doesn't exist
if [ ! -f /etc/nginx/auth/.htpasswd ]; then
  echo "Creating authentication credentials..."
  mkdir -p /etc/nginx/auth
  htpasswd -cb /etc/nginx/auth/.htpasswd "$IPXE_USER" "$IPXE_PASSWORD"
  echo "User created: $IPXE_USER"
  
  # Verify created file
  if [ -f /etc/nginx/auth/.htpasswd ]; then
    echo "htpasswd file created successfully:"
    cat /etc/nginx/auth/.htpasswd
  else
    echo "ERROR: Unable to create htpasswd file"
    exit 1
  fi
else
  echo "Existing authentication file found"
  echo "htpasswd file content:"
  cat /etc/nginx/auth/.htpasswd
fi

# Check directories
mkdir -p /var/www/images /var/www/ignition

# Set permissive permissions
chown -R nginx:nginx /var/www/
chmod -R 755 /var/www/
find /var/www -type f -exec chmod 644 {} \;

echo "==================================="
echo "iPXE Server Docker - Ready"
echo "==================================="
echo "User: $IPXE_USER"
echo "Images: http://server/images/"
echo "Ignition: http://server/ignition/"
echo "==================================="

# Start nginx
exec nginx -g 'daemon off;'