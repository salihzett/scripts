md c:\\HWID
Set-Location c:\\HWID
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Unrestricted
Install-Script -Name Get-WindowsAutoPilotInfo 
$b = hostname
Get-WindowsAutoPilotInfo.ps1 -OutputFile c:\$b.csv
