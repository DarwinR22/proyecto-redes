
# 🔐 Proyecto de Seguridad en Redes TCP/IP en AWS con Terraform

Este repositorio contiene la infraestructura como codigo (IaC) para desplegar una red informatica segura sobre AWS, en el contexto del curso de **Seguridad de Redes TCP/IP**. La solucion cumple con todos los requisitos de infraestructura solicitados, incluyendo servidores clave, dispositivos de seguridad, accesos publicos/privados, y segmentacion de red.

---

## ✅ Fases implementadas

### 🧱 Fase 1: Red Base
- VPC con bloque CIDR personalizado `10.0.0.0/16`
- Subred publica (`10.0.1.0/24`) y privada (`10.0.2.0/24`)
- Internet Gateway + tabla de rutas
- Infraestructura modularizada

### 🌐 Fase 2: Servidor Web
- EC2 con Amazon Linux 2
- Apache instalado automaticamente via `user_data.sh`
- Pagina de login (`index.html`) funcional
- IP publica con acceso controlado
- Seguridad: SG con puertos 80, 22 y 3000

### 🗂️ Fase 3: Sitio Estatico en S3
- Bucket con nombre aleatorio (`random_id`)
- `index.html` publicado automaticamente
- Configuracion `website` y politica publica activa

### 🏢 Fase 4: Controlador de Dominio (AD)
- EC2 con Windows Server 2019
- IP privada fija (`10.0.1.145`)
- Preparado para instalacion de Active Directory y GPOs
- Acceso RDP funcional

### 🛡️ Fase 5: IDS / IPS
- EC2 Ubuntu 22.04 con Suricata
- Instalacion automatica via `user_data.sh`
- Regla personalizada (`alert tcp any any -> any 23`) implementada
- Listo para deteccion de ataques como Telnet, SYN Flood, etc.

### 🔒 Fase 6: VPN y Firewall
- EC2 con AMI oficial de VNS3 (Marketplace Free Tier)
- Acceso Web UI en puerto 8000
- Acceso SSH limitado
- Puerto UDP 51820 habilitado para VPN (WireGuard/IPsec)
- Actua como Firewall y NAT Gateway basico

### 🧪 Fase 7: Simulacion de ataques
- Simulacion de ataque DDoS con multiples peticiones HTTP a servidor web
- Simulacion de SYN Flood detectado por Suricata
- Captura de trafico HTTP (sniffing) con Wireshark desde VPN
- Logs documentados en `/var/log/suricata/`

---

## 🧩 Infraestructura requerida (verificada)

| Componente                       | Estado    |
|----------------------------------|-----------|
| Servidor Web (Apache/IIS)        | ✅ Cumplido |
| Pagina de Login                  | ✅ Cumplido |
| Servidor de Dominio + AD         | ✅ Cumplido |
| Firewall (VNS3)                  | ✅ Cumplido |
| IDS / IPS (Suricata)             | ✅ Cumplido (documentar logs) |
| Accesos Publicos (Web, RDP)      | ✅ Cumplido |
| Accesos Privados (VPN)           | ✅ Cumplido |
| Segmentacion y SGs especificos   | ✅ Cumplido |
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
│   └── vns3_firewall/          # VNS3 VPN/Firewall
```

---

## ⚙ Requisitos para desplegar

- ✅ Terraform v1.3 o superior
- ✅ Cuenta de AWS con permisos de EC2, VPC, S3, IAM
- ✅ Clave SSH valida (`redes-key`)
- ✅ AMIs especificadas en `dev.tfvars`

---

## 🚀 Despliegue rapido

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

## 🚀 Diagrama de Arquitectura

!Diagrama de arquitectura


## 🧠 Notas finales

- Todos los servidores estan desplegados en la region `us-east-1`
- El diseño es modular y facilmente escalable
- Puedes extender esta infraestructura para integrar balanceadores, ACM, o monitoreo con CloudWatch

---

## 👨‍💻 Autor

**Darwin Lopez**  
Proyecto: *Seguridad de Redes TCP/IP*  
Infraestructura 100% implementada con Terraform y AWS  
