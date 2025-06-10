#!/bin/bash
set -e

# Actualizar sistema
apt update -y
apt install -y suricata unzip curl vim htop net-tools

# Asegurar que el servicio SSH esté activo
sed -i 's/^#Port 22/Port 22/' /etc/ssh/sshd_config
sed -i 's/^#PermitRootLogin.*/PermitRootLogin yes/' /etc/ssh/sshd_config
systemctl restart ssh

# Agregar ruta para tráfico desde clientes VPN (solo válida si en subnet privada)
echo "100.64.0.0/10 via 10.0.2.1" >> /etc/network/interfaces.d/vpn-route
ip route add 100.64.0.0/10 via 10.0.2.1 || echo "La ruta será válida al reiniciar en subred privada"

# Ejecutar Suricata en modo IDS pasivo
IFACE=$(ip -o -4 route show to default | awk '{print $5}')
suricata -i $IFACE -D
