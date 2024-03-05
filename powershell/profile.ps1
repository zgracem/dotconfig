# ----------------------------------------------------------------------------
# $PROFILE.CurrentUserAllHosts
#   Windows:   %HOME%/Documents/PowerShell/Profile.ps1
#   Mac/Linux: ~/.config/powershell/profile.ps1
# ----------------------------------------------------------------------------

using namespace System.Security

# Locale
[CultureInfo]::CurrentCulture = "en-CA"

# Setup readline
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

Set-Alias clear Clear-Host
Set-Alias man Get-Help
Set-Alias open Start-Process
Set-Alias pbpaste Get-Clipboard
Set-Alias rm Remove-ItemSafely
Set-Alias wget Invoke-WebRequest

function ListFilesWide { Get-ChildItem -Force $args | Format-Wide -AutoSize }
Set-Alias ls ListFilesWide
function ListFilesLong { Get-ChildItem -Force $args }
Set-Alias ll ListFilesLong

function GetMyIP { Write-Host (Invoke-WebRequest ifconfig.me/ip).Content.Trim() }
Set-Alias myip GetMyIP

function OpenExplorer { explorer $args }
Set-Alias f OpenExplorer

function SelectAllObjects { Select-Object * }
Set-Alias unpack SelectAllObjects

# ----------------------------------------------------------------------------

$env:DOTNET_CLI_TELEMETRY_OPTOUT = 1
$env:POWERSHELL_TELEMETRY_OPTOUT = 1

$global:IsAdmin = if ([OperatingSystem]::IsWindows()) {
    ([Principal.WindowsPrincipal][Principal.WindowsIdentity]::GetCurrent()).IsInRole([Principal.WindowsBuiltInRole]::Administrator)
} elseif ([OperatingSystem]::IsMacOS() -or [OperatingSystem]::IsLinux()) {
    $(id -u) -eq 0
}

# ----------------------------------------------------------------------------

$PSDefaultParameterValues += @{
    'Get-Help:ShowWindow' = $true
    'Out-File:Encoding' = 'utf8'
}

# ----------------------------------------------------------------------------

function Prompt {
    $prefix = ($PSStyle.Foreground.Blue + "PS" + $PSStyle.Reset + " ")
    # $body = $(Get-Location)
    $suffix = ('>' * ($nestedPromptLevel + 1)) + " "
    Return ($prefix + $PWD + $suffix)
}

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ($ShellId + " " + $PSVersionTable.PSVersion)
}
CustomizeConsole
