# after change reload profile using 
# . $PROFILE
# there may be a need to change policie - https:/go.microsoft.com/fwlink/?LinkID=135170

# oh-my-posh init pwsh --config C:\Users\almog\Documents\WindowsPowerShell\craver.omp.json | Invoke-Expression 
# oh-my-posh init pwsh --config "$env:POSH_THEMES_PATH\paradox.omp.json" | Invoke-Expression
Invoke-Expression (& "C:\Program Files\starship\bin\starship.exe" init powershell)

Import-Module -Name Terminal-Icons

# Increase the number of records in your PSReadLine history
Set-PSReadLineOption -MaximumHistoryCount 10000
# get history file
# (Get-PSReadLineOption).HistorySavePath

# Prevent annoying beeping noises (e.g. when pressing backspace on empty line)
Set-PSReadLineOption -BellStyle None

# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete 

# Autocompletion for arrow keys
Set-PSReadlineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadlineKeyHandler -Key DownArrow -Function HistorySearchForward

# set Autocompletion based on history of commands
Set-PSReadLineOption -PredictionSource History

function cdc {
    cd -Path C:\
}

function cdcn {
    cd -Path C:\nanolock
}

function title {
    $host.ui.RawUI.WindowTitle = “Changed Title”
}

function ip {
    ipconfig | findstr v4 | findstr 192.168
}


function update-database {
    dotnet ef database update
}

function up-db {
    dotnet ef database update
}

function git-sync {
    Write-Output pulling
    git pull
    Write-Output pushing
    git push
}

function run-keycloak {
    docker run -p 8080:8080 -e KEYCLOAK_ADMIN=admin -e KEYCLOAK_ADMIN_PASSWORD=admin quay.io/keycloak/keycloak:19.0.0 start-dev
}

function run-rabbitmq {
    docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.10-management
}

function mobba {
    C:\mobba\MobaXterm_Personal_22.1.exe
}

New-Alias -Name "chrome" "C:\Program Files\Google\Chrome\Application\chrome.exe" -EA SilentlyContinue

function chrome-local-rabbitmq {
    chrome http://localhost:15672/
}

function chrome-dev01 {
    chrome https://dev01-gb.nanolocksecurity.nl/
}

function chrome-dev01-keyclock {
    chrome https://dev01-auth.nanolocksecurity.nl/auth/admin/master/console/#/realms/nanolocksec
}

function chrome-dev01-swagger {
    chrome https://dev01-api.nanolocksecurity.nl/swagger/index.html
}

$dev01 = "dev01.nanolocksecurity.nl"

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}


# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.

# add Autocompletion to ssh commands using the .sshConfig
Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
    param($wordToComplete, $commandAst, $cursorPosition)
    $hosts = Get-Content ${Env:HOMEPATH}\.ssh\config | Select-String -Pattern "^Host " | ForEach-Object { $_ -replace "host ", "" } | Sort-Object -Unique

    $textToComplete = $wordToComplete
    $generateCompletionText = {
        param($x)
        $x
    }
    if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$") {
        $textToComplete = $Matches["host"]
        $generateCompletionText = {
            param($hostname)
            $Matches["user"] + "@" + $hostname
        }
    }
}

