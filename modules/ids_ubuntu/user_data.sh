#!/bin/bash
set -e

# 🛠️ Actualizar sistema y herramientas básicas
apt-get update -y
apt-get install -y software-properties-common curl

# 📦 Agregar repositorio oficial de Suricata
add-apt-repository -y ppa:oisf/suricata-stable
apt-get update -y

# 🔒 Instalar Suricata
apt-get install -y suricata

# 🔄 Habilitar e iniciar el servicio de Suricata
systemctl enable suricata
systemctl start suricata

# ⚠️ Agregar una regla personalizada de ejemplo (detección de intento Telnet)
echo 'alert tcp any any -> any 23 (msg:"TELNET attempt"; sid:1000001; rev:1;)' >> /etc/suricata/rules/local.rules

# 📡 Descargar reglas oficiales adicionales
suricata-update || true

# 🔁 Reiniciar Suricata para aplicar nuevas reglas
systemctl restart suricata
