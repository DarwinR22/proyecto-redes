<powershell>
# ---------------------------------------------------
# user_data.ps1 – Configuración de AD, DNS, SSM, RDP y usuarios
# ---------------------------------------------------

# 1) Instalar rol de Active Directory y DNS
Install-WindowsFeature -Name AD-Domain-Services, DNS -IncludeManagementTools

# 2) Promover a Controlador de Dominio
Install-ADDSForest `
  -DomainName "${domain_name}" `
  -SafeModeAdministratorPassword (ConvertTo-SecureString "${safe_mode_password}" -AsPlainText -Force) `
  -Force

# 3) Esperar reinicio
Start-Sleep -Seconds 60

# 4) Habilitar RDP
Set-ItemProperty -Path "HKLM:\System\CurrentControlSet\Control\Terminal Server" -Name "fDenyTSConnections" -Value 0
Enable-NetFirewallRule -DisplayGroup "Remote Desktop"

# 5) Instalar AWS SSM Agent
New-Item -Path "C:\Temp" -ItemType Directory -Force
$ssmInstaller = "https://s3.amazonaws.com/amazon-ssm-us-east-1/latest/windows_amd64/AmazonSSMAgentSetup.exe"
Invoke-WebRequest -Uri $ssmInstaller -OutFile "C:\Temp\AmazonSSMAgentSetup.exe"
Start-Process -FilePath "C:\Temp\AmazonSSMAgentSetup.exe" -ArgumentList "/qn" -Wait
Start-Service AmazonSSMAgent
Set-Service -Name AmazonSSMAgent -StartupType Automatic

# 6) Actualizar políticas y generar reporte
gpupdate /force
gpresult /H C:\gp-report.html

# 7) Descargar y ejecutar script de creación de usuarios
try {
    Invoke-WebRequest -Uri "https://tu-bucket-s3.s3.amazonaws.com/configuracion_ad.ps1" -OutFile "C:\configuracion_ad.ps1"
    powershell.exe -ExecutionPolicy Bypass -File "C:\configuracion_ad.ps1"
} catch {
    Write-Host "⚠️ Error al ejecutar configuracion_ad.ps1: $_"
}

</powershell>
