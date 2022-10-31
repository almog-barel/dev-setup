# making symboing link - New-Item -Path <to> -ItemType SymbolicLink -Value <from>

# link the powershell profile to its intended loacation
del $profile
New-Item -Path $profile -ItemType SymbolicLink -Value .\Microsoft.PowerShell_profile.ps1

# git config
del ~\.gitconfig
New-Item -Path ~\.gitconfig -ItemType SymbolicLink -Value .\.dotfles\.gitconfig