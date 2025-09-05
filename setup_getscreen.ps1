# --- Configure Administrator & RDP ---
$password = ConvertTo-SecureString $env:ADMIN_PASSWORD -AsPlainText -Force
Set-LocalUser -Name 'Administrator' -Password $password
Enable-LocalUser -Name 'Administrator'
Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -Name 'fDenyTSConnections' -Value 0
Enable-NetFirewallRule -DisplayGroup 'Remote Desktop'

# --- Download & Install GetScreen ---
$exePath = "C:\getscreen.exe"
if (-Not (Test-Path $exePath)) {
    Invoke-WebRequest -Uri "https://getscreen.me/download/getscreen_win.exe" -OutFile $exePath
}
Start-Process -FilePath $exePath -ArgumentList "-install -register $env:GETSCREEN_EMAIL" -Wait

# --- Start GetScreen Agent ---
Start-Process -FilePath $exePath -ArgumentList "-start"

# --- Keep VM Alive ---
while ($true) {
    Write-Host ("[KEEP-ALIVE] " + (Get-Date -Format 'yyyy-MM-dd HH:mm:ss') + " - VM vẫn treo")
    Start-Sleep -Seconds 60
}
