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

#During auto completion, pressing arrow key up or down will move the cursor to the end of the completion
Set-PSReadLineOption -HistorySearchCursorMovesToEnd

#Shows tooltip during completion
Set-PSReadLineOption -ShowToolTips

# Set-PSReadLineOption ListView 

function cdc {
    cd -Path C:\
}

function cdn {
    cd -Path C:\nanolock
}

function cdp {
    cd -Path C:\playground
}

function zip {
    param (
        $path
    )
    7z a -tzip $path 
    # not working
}

function unzip {
    param (
        $path
    )
    7z x $path
}

function ip-local {
    ((ipconfig | findstr v4 | findstr 192.168) -split " : " )[-1]
}

function ip-global {
    (curl 'https://api.ipify.org?format=json').Content | jq .ip -r
}

function ip {
    echo "local : $(ip-local)"
    echo "global : $(ip-global)"
}

function new-migration($name) {
    dotnet ef migrations add $name
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
    docker run -it --rm --name rabbitmq -p 5672:5672 -p 15672:15672 rabbitmq:3.10-management --detach
    # docker-compose -f c:\nanoLock\local\docker-compose-rabbitmq.yml up --detach
}

function mobba {
    C:\mobba\MobaXterm_Personal_22.1.exe
}

function guid {
    [guid]::NewGuid().Guid
}


function ListExcludedPortForUser {
    netsh interface ipv4 show excludedportrange protocol=tcp
}

New-Alias -Name "chrome" "C:\Program Files\Google\Chrome\Application\chrome.exe" -EA SilentlyContinue

function ssh-connect {
    $hostsList = Get-Content ${Env:HOMEPATH}\.ssh\config | Select-String -Pattern "^Host " | ForEach-Object { $_ -replace "host ", "" } | Sort-Object -Unique
    gum choose $hostsList
    # $hostname = gum choose $hostsList
    echo $hostname
    # ssh $hostname
}

$local = "http://localhost:4201/"
$local_rabbitmq = "http://localhost:15672/"

$dev01 = "dev01.nanolocksecurity.nl"
$dev01_swagger = "https://dev01-api.nanolocksecurity.nl/swagger/index.html"
$dev01_keyclock = "https://dev01-auth.nanolocksecurity.nl/auth/"
$dev01_keyclock = "http://dev01.nanolocksecurity.nl:8090/"

$devops01 = "dev01.nanolocksecurity.nl"
$devops01_swagger = "https://devops01-opsapi.nanolocksecurity.nl/swagger/index.html"
$devops01_keyclock = "https://devops01-auth.nanolocksecurity.nl/auth/"
$devops01_keyclock = "http://devops01.nanolocksecurity.nl:8090/"

$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}

$hosts = "C:\Windows\System32\drivers\etc\hosts" 

function Invoke-Sudo { Start-Process @args -Verb RunAs }
Set-Alias sudo Invoke-Sudo

Set-Alias grep findstr

function jira
{
    chrome https://nanolocksec.atlassian.net/jira/dashboards/10012
}


Set-Alias wireshark "C:\Program Files\Wireshark\Wireshark.exe"

function title($title)
{
    $Host.UI.RawUI.WindowTitle = "$title"
    echo -ne "\033]0;$title\007"
}



# Import the Chocolatey Profile that contains the necessary code to enable
# tab-completions to function for `choco`.
# Be aware that if you are missing these lines from your profile, tab completion
# for `choco` will not function.
# See https://ch0.co/tab-completion for details.

# add Autocompletion to ssh commands using the .sshConfig
# Register-ArgumentCompleter -CommandName ssh,scp,sftp -Native -ScriptBlock {
#     param($wordToComplete, $commandAst, $cursorPosition)
#     $hosts = Get-Content ${Env:HOMEPATH}\.ssh\config | Select-String -Pattern "^Host " | ForEach-Object { $_ -replace "host ", "" } | Sort-Object -Unique

#     $textToComplete = $wordToComplete
#     $generateCompletionText = {
#         param($x)
#         $x
#     }
#     if ($wordToComplete -match "^(?<user>[-\w/\\]+)@(?<host>[-.\w]+)$") {
#         $textToComplete = $Matches["host"]
#         $generateCompletionText = {
#             param($hostname)
#             $Matches["user"] + "@" + $hostname
#         }
#     }
# }


# Register the custom argument completer for the ssh command
Register-ArgumentCompleter -CommandName ssh -ScriptBlock {
    param($commandName, $parameterName, $wordToComplete, $commandAst, $fakeBoundParameters)

    # Define the custom completion options
    $completionOptions = @(
        'user1@host1',
        'user2@host2',
        'user3@host3'
    )

    # Filter the completion options based on the current input
    $filteredOptions = $completionOptions | Where-Object { $_ -like "$wordToComplete*" }

    # Return the completion results
    $filteredOptions | ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}


# Install the PSMenu module
# Install-Module PSMenu

Set-PSReadLineKeyHandler -Chord 'Ctrl+Spacebar' -ScriptBlock {
    # Get the current command line input
    $commandLine = [Microsoft.PowerShell.PSConsoleReadLine]::GetBufferState().CurrentLine

    # Check if the ssh command is being used
    if ($commandLine -like 'ssh *') {
        # Define the custom completion options
        $completionOptions = @(
            'user1@host1',
            'user2@host2',
            'user3@host3'
        )

        # Display the completion options in a menu
        $chosenOption = Show-Menu -Title 'SSH Completion Options' -MenuItems $completionOptions

        # Insert the chosen option into the command line
        if ($chosenOption) {
            [Microsoft.PowerShell.PSConsoleReadLine]::Insert($chosenOption)
        }
    }
}

function cpwd {
    (pwd).Path | clip
}


#####


function Get_FliterdChild {
    param(

    )

    Get-ChildItem -Name | gum filter
}





