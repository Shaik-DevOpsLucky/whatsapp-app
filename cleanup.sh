#!/bin/bash

echo "Stopping Apache service..."
systemctl stop apache2 2>/dev/null

echo "Removing Apache2 and Git packages..."
apt remove --purge -y apache2 git

echo "Cleaning up unused dependencies..."
apt autoremove --purge -y
apt autoclean -y

echo "Removing /var/www/html directory..."
rm -rf /var/www/html

echo "Removing Apache logs..."
rm -rf /var/log/apache2

echo "Killing any remaining Apache processes..."
pkill -9 apache2 2>/dev/null

echo "Removing any leftover cloned repositories..."
rm -rf /tmp/axiom-site
rm -rf /root/axiom-whatsapp-ui-homePage

echo "Verifying cleanup..."

if ! command -v apache2 >/dev/null 2>&1; then
    echo "✔️ Apache2 successfully removed."
else
    echo "❌ Apache2 still exists."
fi

if ! command -v git >/dev/null 2>&1; then
    echo "✔️ Git successfully removed."
else
    echo "❌ Git still exists."
fi

echo "Cleanup completed."
