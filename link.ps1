# making symboing link - New-Item -Path <to> -ItemType SymbolicLink -Value <from>

# link the powershell profile to its intended loacation
New-Item -Path $profile -ItemType SymbolicLink -Value .\Microsoft.PowerShell_profile.ps1 -Force

# git config
New-Item -Path ~\.gitconfig -ItemType SymbolicLink -Value .\.dotfles\.gitconfig -Force

#vs-code setttings
New-Item -Path ~\AppData\Roaming\Code\User\keybindings.json -ItemType SymbolicLink -Value .\.dotfles\vscode\keybindings.json -Force
New-Item -Path ~\AppData\Roaming\Code\User\settings.json -ItemType SymbolicLink -Value .\.dotfles\vscode\settings.json -Force
New-Item -Path ~\AppData\Roaming\Code\User\snippets -ItemType SymbolicLink -Value .\.dotfles\vscode\snippets -Force

#cchrome bookmarks
New-Item -Path '~\AppData\Local\Google\Chrome\User Data\Default\Bookmarks' -ItemType SymbolicLink -Value .\.dotfles\chrome\Bookmarks -Force