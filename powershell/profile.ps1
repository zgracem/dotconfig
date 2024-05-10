# ----------------------------------------------------------------------------
# $PROFILE.CurrentUserAllHosts
#   Windows:   %HOME%/Documents/PowerShell/Profile.ps1
#   Mac/Linux: ~/.config/powershell/profile.ps1
# ----------------------------------------------------------------------------

using namespace System.Security
using namespace System.Text

# Locale
[CultureInfo]::CurrentCulture = "en-CA"

# ----------------------------------------------------------------------------

$env:XDG_CONFIG_HOME = "$env:USERPROFILE\.config"
$env:XDG_DATA_HOME = "$env:USERPROFILE\.local\share"

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
Set-Alias pbcopy Set-Clipboard
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

function Write-DidYouMean {
    Write-Host ("Did you mean " + $PSStyle.Underline + $args[0] + $PSStyle.Reset + "?")
}

function objects { process { $_ | Select-Object * } }
function unpack { Write-DidYouMean "objects" }

function members { process { $_ | Get-Member } }
function about { Write-DidYouMean "members" }

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
    $local:uid -eq 0 # -or $local:uid -eq 501
} elseif ($IsLinux) {
    $local:uid = $(id -u)
    $local:uid -eq 0
}

# ----------------------------------------------------------------------------

# Setup PSReadline
if ($Host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    $local:PSReadLineOptions = @{
        BellStyle = "Visual"
        EditMode = "Emacs"
        HistoryNoDuplicates = $true
        HistorySavePath = "$env:XDG_DATA_HOME\powershell\PSReadLine\ConsoleHost_history.txt"
        HistorySearchCursorMovesToEnd = $true
        PredictionSource = "HistoryAndPlugin"
    }
    Set-PSReadLineOption @PSReadLineOptions
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

function Prompt {
    $local:ThisDir = [string] ""
    $local:Sigil = [string] ">"
    $local:SigilColour = $PSStyle.Foreground.BrightBlue

    # Use ProviderPath if there's no drive defined for the location provider.
    $ThisDir = if ($executionContext.SessionState.Path.CurrentLocation.Drive) {
        $executionContext.SessionState.Path.CurrentLocation.Path
    }
    else {
        $executionContext.SessionState.Path.CurrentLocation.ProviderPath
    }

    # Replace path to home directory with `~`
    if ($ThisDir -like "$Home*") {
        $ThisDir = $ThisDir.Replace($Home, '~')
    }
    # Reverse backslashes
    $ThisDir = $ThisDir.Replace(
        [System.IO.Path]::DirectorySeparatorChar,
        [System.IO.Path]::AltDirectorySeparatorChar)

    if ($global:IsAdmin -eq $true) {
        $Sigil = "!>"
        $SigilColour = $PSStyle.Foreground.Red
    }

    $ThisDir = $PSStyle.Foreground.White + $ThisDir + $PSStyle.Reset

    # $Sigil = $SigilColour + ($Sigil * ($nestedPromptLevel + 1)) + $PSStyle.Reset
    $Sigil = $SigilColour + $Sigil + $PSStyle.Reset

    Return ($PSStyle.Reset + $ThisDir + " " + $Sigil + " ")
}

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ("Windows PowerShell", $PSVersionTable.PSVersion -join " ")
}
CustomizeConsole

# ----------------------------------------------------------------------------

$local:PrivatePSDir = "$PSScriptRoot/../../.private/powershell"
if (Test-Path -Type Container $PrivatePSDir) {
    . "$PrivatePSDir/profile.ps1"
}
