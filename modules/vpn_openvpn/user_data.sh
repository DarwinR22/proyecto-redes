#!/bin/bash
# ✅ Habilita el acceso SSH en VNS3 en caso de estar deshabilitado por defecto

apt-get update -y
apt-get install -y openssh-server

# Habilita y arranca el servicio SSH
systemctl enable ssh
systemctl start ssh

# Asegura que exista el usuario 'ubuntu'
id ubuntu &>/dev/null || useradd -m -s /bin/bash ubuntu

# Asigna contraseña al usuario ubuntu (⚠️ solo para pruebas)
echo "ubuntu:Redes123!" | chpasswd

# Configura clave pública SSH para el usuario ubuntu
mkdir -p /home/ubuntu/.ssh
echo "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCf/KVONjIU00V6euS4475Kxo6+TnkTNPONqo/F3pOcfxpsJF+xP4+PsME9me81tRPKFErMnOEIMEqjOvy44WKbRILSZFWk7co/Cas8BxgBaZeB0/9Bf/2tmSP3eYhL5MzDNSjUAlS/1d1rkFsUyT9Yu7Sx55FgqgjUHHsbilKmYSatXxsZHSV80xydQ85zJW/eddi6fbLqLnUk8LAduz4QZIqRMTDFTo29Xbg/ImDofzTuVw2pvI7gPqV6Cq7d5JDmxnFhz7l0vNqXZE9irpMCxQCN4TdnQ+W5mWxKYkUbHJzGXdGmjvnYQx07pl8UWNRVXzmuWw0OQjqXLYlTon0d" > /home/ubuntu/.ssh/authorized_keys
chmod 600 /home/ubuntu/.ssh/authorized_keys
chown -R ubuntu:ubuntu /home/ubuntu/.ssh
