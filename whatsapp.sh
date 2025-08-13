#!/bin/bash

# Update apt repo and install Apache2 and Git
apt update
apt install -y apache2 git

# Start and enable Apache2 service
systemctl start apache2
systemctl enable apache2

# Ensure the document root exists and is empty
WEBROOT="/var/www/html"
if [ ! -d "$WEBROOT" ]; then
  mkdir -p $WEBROOT
fi

# Optional: clean existing files in the document root
rm -rf $WEBROOT/*

# Clone website files into the document root
git clone https://github.com/hamsahmedansari/axiom-whatsapp-ui-homePage.git /tmp/axiom-site

# Move site files to the document root
mv /tmp/axiom-site/* $WEBROOT/

# Clean up the temp folder
rm -rf /tmp/axiom-site

# Show the last 100 lines of the Apache access log and follow it
tail -100f /var/log/apache2/access.log
