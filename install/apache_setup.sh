#!/bin/bash

sudo apt-get install -y apache2
sudo a2enmod proxy proxy_http rewrite ssl
sudo mkdir /etc/apache2/ssl
sudo cp ~/grits-deploy-scripts/ssl/apache.crt /etc/apache2/ssl/apache.crt
sudo cp ~/grits-deploy-scripts/ssl/apache.key /etc/apache2/ssl/apache.key
# Install a config file for proxying the meteor dashboard
# and girder
sudo tee /etc/apache2/conf-available/proxy.conf <<EOF
Listen 443 http
Listen 80
<VirtualHost *:80>
  ServerName $APACHE_URL
  RewriteEngine on
  RewriteCond %{HTTPS} off
  RewriteRule ^(.*) https://%{HTTP_HOST}%{REQUEST_URI}
</VirtualHost>
<VirtualHost *:443>
  ServerName $APACHE_URL
  SSLEngine on
  SSLCertificateFile /etc/apache2/ssl/apache.crt
  SSLCertificateKeyFile /etc/apache2/ssl/apache.key
  ProxyPreserveHost On
  RewriteEngine on
  RewriteRule ^/gritsdb$ /gritsdb/ [R]
  ProxyPass /gritsdb/ http://localhost:9999/
  ProxyPassReverse /gritsdb/ http://localhost:9999/
  ProxyPass / http://localhost:3001/
  ProxyPassReverse / http://localhost:3001/
</VirtualHost>
EOF
sudo a2enconf proxy
sudo apache2ctl restart
