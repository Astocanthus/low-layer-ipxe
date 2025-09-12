#!/bin/sh

# Variables d'environnement par défaut
IPXE_USER=${IPXE_USER:-admin}
IPXE_PASSWORD=${IPXE_PASSWORD:-changeme}

# Création du fichier de mots de passe si il n'existe pas
if [ ! -f /etc/nginx/auth/.htpasswd ]; then
    echo "Création des identifiants d'authentification..."
    mkdir -p /etc/nginx/auth
    htpasswd -cb /etc/nginx/auth/.htpasswd "$IPXE_USER" "$IPXE_PASSWORD"
    echo "Utilisateur créé: $IPXE_USER"
    
    # Vérification du fichier créé
    if [ -f /etc/nginx/auth/.htpasswd ]; then
        echo "Fichier htpasswd créé avec succès:"
        cat /etc/nginx/auth/.htpasswd
    else
        echo "ERREUR: Impossible de créer le fichier htpasswd"
        exit 1
    fi
else
    echo "Fichier d'authentification existant trouvé"
    echo "Contenu du fichier htpasswd:"
    cat /etc/nginx/auth/.htpasswd
fi

# Vérification des répertoires
mkdir -p /var/www/images /var/www/ignition

# Permissions plus permissives
chown -R nginx:nginx /var/www/
chmod -R 755 /var/www/
find /var/www -type f -exec chmod 644 {} \;

echo "==================================="
echo "iPXE Server Docker - Prêt"
echo "==================================="
echo "Utilisateur: $IPXE_USER"
echo "Images: http://server/images/"
echo "Ignition: http://server/ignition/"
echo "==================================="

# Démarrage de nginx
exec nginx -g 'daemon off;'