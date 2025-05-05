# Proyecto de Seguridad en Redes TCP/IP en AWS con Terraform

Este repositorio contiene la infraestructura como código (IaC) para desplegar una arquitectura segura en AWS, orientada a un entorno de prácticas de redes TCP/IP.

## ✅ Fases implementadas

### Fase 1: Networking Base (100%)

- VPC con CIDR personalizado (`10.0.0.0/16`)
- Subred pública (`10.0.1.0/24`) y privada (`10.0.2.0/24`)
- Internet Gateway + tabla de ruteo
- Todo modularizado

### Fase 2: EC2 Servidor Web (100%)

- Instancia EC2 Amazon Linux 2023
- Apache instalado automáticamente
- Página de prueba (`index.html`) accesible vía navegador
- Seguridad con SG HTTP y SSH

### Fase 3.1: Hosting Estático con S3 (100%)

- Bucket con nombre aleatorio (usando `random_id`)
- Página `index.html` desplegada automáticamente
- Configuración de política pública y website activa
- Permisos AWS configurados correctamente (sin ACLs)

## ⏳ Fases futuras

- [ ] 3.2: Elastic IP para mantener IP fija
- [ ] 3.3: Firewall pfSense (VPN + IDS)
- [ ] 3.4: Controlador de Dominio (AD)
- [ ] 3.5: NAT Gateway
- [ ] 3.6: Load Balancer con HTTPS (ACM)
- [ ] 3.7: CloudWatch para monitoreo

## 📁 Estructura del proyecto

```
terraform/
├── main.tf
├── variables.tf
├── outputs.tf
├── provider.tf
├── modules/
│   ├── vpc/
│   ├── networking/
│   ├── ec2/
│   └── s3_static_site/
```

## ⚙ Requisitos

- Terraform v1.3+
- Cuenta AWS con permisos suficientes
- Llave SSH configurada (`redes-key`)
- Permisos S3 y EC2 completos (IAM)

## 🚀 Cómo usar

```bash
terraform init
terraform apply -var-file="terraform.tfvars"
```

## 🧹 Limpieza de recursos

```bash
terraform destroy
```

## 📌 Autor

Darwin López
