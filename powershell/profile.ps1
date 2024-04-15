# ----------------------------------------------------------------------------
# $PROFILE.CurrentUserAllHosts
#   Windows:   %HOME%/Documents/PowerShell/Profile.ps1
#   Mac/Linux: ~/.config/powershell/profile.ps1
# ----------------------------------------------------------------------------

using namespace System.Security
using namespace System.Text

# Locale
[CultureInfo]::CurrentCulture = "en-CA"

# $historyFile = $env:APPDATA\Microsoft\Windows\PowerShell\PSReadLine\ConsoleHost_history.txt

# ----------------------------------------------------------------------------

$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"

$PSDefaultParameterValues += @{
    'Format-*:AutoSize' = $true
    'Format-*:Wrap' = $true
    'Get-Help:ShowWindow' = $true
    'Out-File:Encoding' = 'utf8'
    'Remove-Item:Confirm' = $true
}

Set-Alias clear Clear-Host
Set-Alias man Get-Help
Set-Alias open Invoke-Item
Set-Alias pbpaste Get-Clipboard
Set-Alias rm Remove-Item
Set-Alias sudo Invoke-Elevated
Set-Alias wget Invoke-WebRequest

function Get-AllItemsWide { Get-ChildItem -Force @Args | Format-Wide }
Set-Alias ls Get-AllItemsWide
function Get-AllItemsLong { Get-ChildItem -Force @Args }
Set-Alias ll Get-AllItemsLong

function Open-ExplorerHere { explorer.exe $args[0] }
Set-Alias f Open-ExplorerHere

function reveal { explorer.exe "/select,$args[0]" }

function myip { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }

function unpack { process { $_ | Select-Object * } }

function about { process { $_ | Get-Member } }

function which { Get-Command -Name $args[0] -All -ErrorAction SilentlyContinue }

function how { Get-Command -Name $args[0] -Syntax -ErrorAction SilentlyContinue }

function .. { Set-Location .. }
function ... { Set-Location ..\.. }
function .... { Set-Location ..\..\.. }

# ----------------------------------------------------------------------------

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

$global:IsAdmin = if ($IsWindows) {
    $local:CurrentUser = [Principal.WindowsPrincipal][Principal.WindowsIdentity]::GetCurrent()
    $local:CurrentUser.IsInRole([Principal.WindowsBuiltInRole]::Administrator)
} elseif ($IsMacOS) {
    $local:uid = $(id -u)
    $local:uid -eq 0 -or $local:uid -eq 501
} elseif ($IsLinux) {
    $local:uid = $(id -u)
    $local:uid -eq 0
}

# ----------------------------------------------------------------------------

# Setup PSReadline
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    $PSReadLineOptions = @{
        BellStyle = "Visual"
        EditMode = "Emacs"
        HistorySearchCursorMovesToEnd = $true
        PredictionSource = "HistoryAndPlugin"
    }
    Set-PSReadLineOption @PSReadLineOptions
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

function Prompt {
    $local:CurrentPath = [string] ""
    $local:Sigil = [string] ">"
    $local:SigilColour = $PSStyle.Foreground.Blue

    # Use ProviderPath if there's no drive defined for the location provider.
    $CurrentPath = if ($executionContext.SessionState.Path.CurrentLocation.Drive) {
        $executionContext.SessionState.Path.CurrentLocation.Path
    }
    else {
        $executionContext.SessionState.Path.CurrentLocation.ProviderPath
    }

    # Replace path to home directory with `~`
    if ($CurrentPath -like "$Home*") { $CurrentPath = $CurrentPath.Replace($Home, '~') }
    # Reverse backslashes
    $CurrentPath = $CurrentPath.Replace([System.IO.Path]::DirectorySeparatorChar, [System.IO.Path]::AltDirectorySeparatorChar)

    if ($global:IsAdmin -eq $true) { $SigilColour = $PSStyle.Foreground.Blue }

    $Sigil = $SigilColour + ($Sigil * ($nestedPromptLevel + 1)) + $PSStyle.Reset

    Return ($PSStyle.Reset + $CurrentPath + " " + $Sigil + " ")
}

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ($ShellId, $PSVersionTable.PSVersion -join " ")
}
CustomizeConsole

# ----------------------------------------------------------------------------

if (Test-Path -Type Container $PSScriptRoot/../../.private/powershell) {
    . "$PSScriptRoot/../../.private/powershell/profile.ps1"
}
