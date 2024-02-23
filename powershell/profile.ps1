# $PROFILE.CurrentUserAllHosts
#   ~/.config/powershell/profile.ps1

function CustomizeConsole {
    $Host.UI.RawUI.WindowTitle = ($ShellId + " " + $PSVersionTable.PSVersion)
    Clear-Host
}
CustomizeConsole

function Prompt {
    $prefix = ($PSStyle.Foreground.Blue + "PS" + $PSStyle.Reset + " ")
    # $body = $(Get-Location)
    $suffix = ('>' * ($nestedPromptLevel + 1)) + " "
    Return ($prefix + $PWD + $suffix)
}
