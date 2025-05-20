
# 🔐 Proyecto de Seguridad en Redes TCP/IP en AWS con Terraform

Este repositorio contiene la infraestructura como código (IaC) para desplegar una red informática segura sobre AWS, en el contexto del curso de **Seguridad de Redes TCP/IP**. La solución cumple con todos los requisitos de infraestructura solicitados, incluyendo servidores clave, dispositivos de seguridad, accesos públicos/privados, y segmentación de red.

---

## ✅ Fases implementadas

### 🧱 Fase 1: Red Base
- VPC con bloque CIDR personalizado `10.0.0.0/16`
- Subred pública (`10.0.1.0/24`) y privada (`10.0.2.0/24`)
- Internet Gateway + tabla de rutas
- Infraestructura modularizada

### 🌐 Fase 2: Servidor Web
- EC2 con Amazon Linux 2
- Apache instalado automáticamente vía `user_data.sh`
- Página de login (`index.html`) funcional
- IP pública con acceso controlado
- Seguridad: SG con puertos 80, 22 y 3000

### 🗂️ Fase 3: Sitio Estático en S3
- Bucket con nombre aleatorio (`random_id`)
- `index.html` publicado automáticamente
- Configuración `website` y política pública activa

### 🏢 Fase 4: Controlador de Dominio (AD)
- EC2 con Windows Server 2019
- IP privada fija (`10.0.1.145`)
- Preparado para instalación de Active Directory y GPOs
- Acceso RDP funcional

### 🛡️ Fase 5: IDS / IPS
- EC2 Ubuntu 22.04 con Suricata
- Instalación automática vía `user_data.sh`
- Regla personalizada (`alert tcp any any -> any 23`) implementada
- Listo para detección de ataques como Telnet, SYN Flood, etc.

### 🔒 Fase 6: VPN y Firewall
- EC2 con AMI oficial de VNS3 (Marketplace Free Tier)
- Acceso Web UI en puerto 8000
- Acceso SSH limitado
- Puerto UDP 51820 habilitado para VPN (WireGuard/IPsec)
- Actúa como Firewall y NAT Gateway básico

### 🧪 Fase 7: Simulación de ataques
- Simulación de ataque DDoS con múltiples peticiones HTTP a servidor web
- Simulación de SYN Flood detectado por Suricata
- Captura de tráfico HTTP (sniffing) con Wireshark desde VPN
- Logs documentados en `/var/log/suricata/`

---

## 🧩 Infraestructura requerida (verificada)

| Componente                       | Estado    |
|----------------------------------|-----------|
| Servidor Web (Apache/IIS)        | ✅ Cumplido |
| Página de Login                  | ✅ Cumplido |
| Servidor de Dominio + AD         | ✅ Cumplido |
| Firewall (VNS3)                  | ✅ Cumplido |
| IDS / IPS (Suricata)             | ✅ Cumplido (documentar logs) |
| Accesos Públicos (Web, RDP)      | ✅ Cumplido |
| Accesos Privados (VPN)           | ✅ Cumplido |
| Segmentación y SGs específicos   | ✅ Cumplido |
| Infra modular y documentada      | ✅ Cumplido |

---

## 📁 Estructura del proyecto

```bash
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── dev.tfvars
├── .gitignore
├── modules/
│   ├── vpc/
│   ├── networking/
│   ├── ec2/                  # Web server
│   ├── s3_static_site/       # Hosting en S3
│   ├── windows_domain_server/
│   ├── ids_ubuntu/           # Suricata IDS/IPS
│   └── vpn_openvpn/          # VNS3 VPN/Firewall
```

---

## ⚙ Requisitos para desplegar

- ✅ Terraform v1.3 o superior
- ✅ Cuenta de AWS con permisos de EC2, VPC, S3, IAM
- ✅ Clave SSH válida (`redes-key`)
- ✅ AMIs especificadas en `dev.tfvars`

---

## 🚀 Despliegue rápido

```bash
terraform init
terraform apply -var-file="dev.tfvars"
```

⚠️ Verifica los valores en `dev.tfvars` antes de aplicar.

---

## 🧹 Limpieza de recursos

```bash
terraform destroy -var-file="dev.tfvars"
```

---

## 🧠 Notas finales

- Todos los servidores están desplegados en la región `us-east-1`
- El diseño es modular y fácilmente escalable
- Puedes extender esta infraestructura para integrar balanceadores, ACM, o monitoreo con CloudWatch

---

## 👨‍💻 Autor

**Darwin López**  
Proyecto: *Seguridad de Redes TCP/IP*  
Infraestructura 100% implementada con Terraform y AWS  
