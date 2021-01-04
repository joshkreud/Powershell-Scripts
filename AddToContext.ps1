
$command =  "powershell -noexit $PSScriptRoot\releaseFile.ps1 '%1'"
$key = "Registry::HKEY_CURRENT_USER\Software\Classes\`*\shell\ReleaseFile"
New-Item -Path $key"\Command" -Value $command  -Force