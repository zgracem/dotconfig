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
Set-Alias open Start-Process
Set-Alias pbpaste Get-Clipboard
Set-Alias rm Remove-Item
Set-Alias sudo Invoke-Elevated
Set-Alias wget Invoke-WebRequest

function ListFilesWide { Get-ChildItem -Force @Args | Format-Wide -AutoSize }
Set-Alias ls ListFilesWide
function ListFilesLong { Get-ChildItem -Force @Args }
Set-Alias ll ListFilesLong

function Get-MyIP { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }
Set-Alias myip Get-MyIP

function Open-Explorer { explorer.exe $args[0] }
Set-Alias f Open-Explorer

function Show-InExplorer { explorer.exe /reveal $args[0] }
Set-Alias reveal Show-InExplorer

function Select-AllObjects { Select-Object * }
Set-Alias unpack Select-AllObjects

# ----------------------------------------------------------------------------

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

$global:IsAdmin = if ([OperatingSystem]::IsWindows()) {
    $local:CurrentUser = [Principal.WindowsPrincipal][Principal.WindowsIdentity]::GetCurrent()
    $local:CurrentUser.IsInRole([Principal.WindowsBuiltInRole]::Administrator)
} elseif ([OperatingSystem]::IsMacOS()) {
    $local:uid = $(id -u)
    $local:uid -eq 0 -or $local:uid -eq 501
} elseif ([OperatingSystem]::IsLinux()) {
    $local:uid = $(id -u)
    $local:uid -eq 0
}

# ----------------------------------------------------------------------------

function Prompt {
    $local:colour = [string] ""
    $local:prefix = [string] ""
    $local:path = [string] ""
    $local:suffix = [string] ""

    $colour = if ($global:IsAdmin -eq $true) {
        $PSStyle.Foreground.BrightRed
    } else {
        $PSStyle.Foreground.BrightBlue
    }
    $prefix = ($colour + "PS" + $PSStyle.Reset + " ")

    # Use ProviderPath if there's no drive defined for the location provider.
    $path = if ($executionContext.SessionState.Path.CurrentLocation.Drive) {
        $executionContext.SessionState.Path.CurrentLocation.Path
    }
    else {
        $executionContext.SessionState.Path.CurrentLocation.ProviderPath
    }
    if ($path -like "$Home*") { $path = $path.Replace($Home, '~') }

    $suffix = ('>' * ($nestedPromptLevel + 1)) + " "

    Return ($prefix + $path + $suffix)
}

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ($ShellId + " " + $PSVersionTable.PSVersion)
}
CustomizeConsole
