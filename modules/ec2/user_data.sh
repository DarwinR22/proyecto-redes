#!/bin/bash
yum update -y
yum install -y httpd mod_ssl

# Instalar Node.js y npm (versión 18 LTS)
curl -sL https://rpm.nodesource.com/setup_18.x | bash -
yum install -y nodejs git

# Activar y asegurar Apache
cat <<EOF >> /etc/httpd/conf/httpd.conf
<Directory /var/www/html>
    Options -Indexes
</Directory>

Header always set X-Frame-Options "DENY"
Header always set X-Content-Type-Options "nosniff"
Header always set X-XSS-Protection "1; mode=block"
EOF

systemctl enable httpd
systemctl start httpd

# Crear estructura de carpetas
mkdir -p /var/www/html/css
mkdir -p /var/www/html/js
mkdir -p /var/www/api

# Copiar frontend
echo "${index_html}" | base64 -d > /var/www/html/index.html
echo "${home_html}"  | base64 -d > /var/www/html/home.html
echo "${style_css}"  | base64 -d > /var/www/html/css/style.css
echo "${login_js}"   | base64 -d > /var/www/html/js/login.js

# Copiar backend
echo "${login_api}" | base64 -d > /var/www/api/login-api.js

# Cambiar propietario para que node pueda ejecutar como ec2-user
chown -R ec2-user:ec2-user /var/www/api

# Instalar dependencias y ejecutar backend
sudo -u ec2-user bash << 'EOF'
cd /var/www/api
npm init -y
npm install express body-parser cors ldapjs
nohup node login-api.js > output.log 2>&1 &
EOF
