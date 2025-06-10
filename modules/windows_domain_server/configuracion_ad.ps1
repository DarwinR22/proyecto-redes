# ---------------------------------------------
# Script: configuracion_ad.ps1
# Objetivo: crear OU y usuarios en AD
# ---------------------------------------------

# Crear OU (si no existe)
if (-not (Get-ADOrganizationalUnit -Filter "Name -eq 'Usuarios'")) {
    New-ADOrganizationalUnit -Name "Usuarios" -Path "DC=project-redes,DC=local" -ProtectedFromAccidentalDeletion $false
}

# Definir usuarios a crear
$usuarios = @(
    @{ Nombre = "maryory.villar"; Usuario = "maryory.villar"; Email = "maryory.villar@project-redes.local" },
    @{ Nombre = "darwin.lopez"; Usuario = "darwin.lopez"; Email = "darwin.lopez@project-redes.local" }
)

foreach ($u in $usuarios) {
    if (-not (Get-ADUser -Filter "SamAccountName -eq '$($u.Usuario)'")) {
        New-ADUser `
            -Name $u.Nombre `
            -SamAccountName $u.Usuario `
            -UserPrincipalName $u.Email `
            -AccountPassword (ConvertTo-SecureString "Redes2023!" -AsPlainText -Force) `
            -Enabled $true `
            -Path "OU=Usuarios,DC=project-redes,DC=local" `
            -ChangePasswordAtLogon $false `
            -PasswordNeverExpires $true `
            -GivenName $u.Nombre.Split('.')[0] `
            -Surname $u.Nombre.Split('.')[1]
    }
}

# Mostrar los usuarios creados
Get-ADUser -Filter * -SearchBase "OU=Usuarios,DC=project-redes,DC=local" | Format-Table Name, SamAccountName, Enabled

