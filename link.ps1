# making symboing link - New-Item -Path <to> -ItemType SymbolicLink -Value <from>

# link the powershell profile to its intended loacation
New-Item -Path $profile -ItemType SymbolicLink -Value ./Microsoft.PowerShell_profile.ps1