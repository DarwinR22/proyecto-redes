#!/bin/bash
set -e

# Actualizar e instalar SSH
apt-get update -y
apt-get install -y openssh-server

# Habilitar SSH al arranque y encenderlo
systemctl enable ssh
systemctl start ssh
