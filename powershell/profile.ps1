# ----------------------------------------------------------------------------
# $PROFILE.CurrentUserAllHosts
#   Windows:   %HOME%/Documents/PowerShell/Profile.ps1
#   Mac/Linux: ~/.config/powershell/profile.ps1
# ----------------------------------------------------------------------------

using namespace System.Security
using namespace System.Text

# Locale
[CultureInfo]::CurrentCulture = "en-CA"

# Setup PSReadline
if ($host.Name -eq 'ConsoleHost') {
    Import-Module PSReadLine
    # $PSReadLineOptions = @{
    #     PredictionSource = "HistoryAndPlugin"
    #     PredictionViewStyle = "ListView"
    #     HistoryNoDuplicates = $true
    #     HistorySearchCursorMovesToEnd = $true
    #     ShowTooltips = $false
    #     EditMode = "Windows"
    #     BellStyle = "None"
    # }
    # Set-PSReadLineOption @PSReadLineOptions
    Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
    Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
}

# Add VS Code CLI to path
$env:Path = $env:Path, "$env:LOCALAPPDATA\Programs\Microsoft VS Code\bin" -join ';'

# ----------------------------------------------------------------------------

$PSDefaultParameterValues += @{
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

function Get-AllItemsWide { Get-ChildItem -Force @Args | Format-Wide -AutoSize }
Set-Alias ls Get-AllItemsWide
function Get-AllItemsLong { Get-ChildItem -Force @Args }
Set-Alias ll Get-AllItemsLong

function myip { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }

function Open-ExplorerHere { explorer.exe $args[0] }
Set-Alias f Open-ExplorerHere

function reveal { explorer.exe /reveal $args[0] } # doesn't work

function unpack { process { $_ | Select-Object * } }

function about { process { $_ | Get-Member } }

function .. { Set-Location .. }

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

function Prompt {
    $local:path = [string] ""
    $local:pathColour = $PSStyle.Foreground.BrightBlack
    $local:pathParentColour = $PSStyle.Foreground.BrightBlack
    $local:sigil = [string] ">"
    $local:sigilColour = $PSStyle.Foreground.Blue

    # Use ProviderPath if there's no drive defined for the location provider.
    $path = if ($executionContext.SessionState.Path.CurrentLocation.Drive) {
        $executionContext.SessionState.Path.CurrentLocation.Path
    }
    else {
        $executionContext.SessionState.Path.CurrentLocation.ProviderPath
    }

    # Replace path to home directory with `~`
    if ("$path" -eq "$Home") {
        $path = $path.Replace($Home, '~')
    } else {
        $local:parentDir = Get-Item $path | Split-Path -Parent
        if ($parentDir -like "$Home*") { $parentDir = $parentDir.Replace($Home, '~') }
        $local:baseDir = Get-Item $path | Split-Path -Leaf
        $local:pathSep = [System.IO.Path]::DirectorySeparatorChar
        $path = $PSStyle.Foreground.BrightBlack + $parentDir + $pathSep + $PSStyle.Reset + $baseDir
    }

    if ($global:IsAdmin -eq $true) { $sigilColour = $PSStyle.Foreground.Blue }

    $sigil = $sigilColour + ($sigil * ($nestedPromptLevel + 1)) + $PSStyle.Reset

    Return ($PSStyle.Reset + $path + " " + $sigil + " ")
}

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ($ShellId + " " + $PSVersionTable.PSVersion)
}
CustomizeConsole
