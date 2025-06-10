#!/bin/bash
set -e

# 📦 Actualizar sistema y herramientas necesarias
yum update -y
yum install -y httpd mod_ssl gcc-c++ make nodejs git certbot python3-certbot-apache

# 🔐 Configurar cabeceras de seguridad en Apache
cat <<EOF >> /etc/httpd/conf/httpd.conf
<Directory /var/www/html>
    Options -Indexes
</Directory>

Header always set X-Frame-Options "DENY"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
EOF

# 🚀 Habilitar Apache
systemctl enable httpd
systemctl start httpd

# 🗂️ Crear estructura de archivos
mkdir -p /var/www/html/css
mkdir -p /var/www/html/js
mkdir -p /var/www/api

# 📁 Instalar archivos frontend (HTML, CSS, JS)
echo "${index_html}" | base64 -d > /var/www/html/index.html
echo "${home_html}"  | base64 -d > /var/www/html/home.html
echo "${style_css}"  | base64 -d > /var/www/html/css/style.css
echo "${login_js}"   | base64 -d > /var/www/html/js/login.js

# 📁 Instalar backend API
echo "${login_api}" | base64 -d > /var/www/api/login-api.js
chown -R ec2-user:ec2-user /var/www/api

# 📦 Instalar dependencias Node.js como ec2-user
sudo -u ec2-user bash << 'EOF'
cd /var/www/api
npm init -y
npm install express body-parser cors ldapjs
EOF

# ⚙️ Crear servicio systemd para login-api.js (HTTPS en puerto 443)
cat <<EOT > /etc/systemd/system/login-api.service
[Unit]
Description=Node.js LDAP Login API
After=network.target

[Service]
WorkingDirectory=/var/www/api
ExecStart=/usr/bin/node /var/www/api/login-api.js
Restart=always
User=ec2-user
Environment=NODE_ENV=production

[Install]
WantedBy=multi-user.target
EOT

# 🔁 Reiniciar systemd y activar servicio
systemctl daemon-reexec
systemctl daemon-reload
systemctl enable login-api.service
systemctl start login-api.service
