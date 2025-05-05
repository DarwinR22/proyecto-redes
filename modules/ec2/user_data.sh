#!/bin/bash
yum update -y
yum install -y httpd
systemctl start httpd
systemctl enable httpd
echo "<h1>Proyecto Seguridad TCP/IP en AWS - Fase 3</h1><p>Servidor configurado por Terraform</p>" > /var/www/html/index.html
