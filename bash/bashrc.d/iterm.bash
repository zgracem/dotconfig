[[ $TERM_PROGRAM == iTerm.app ]] || return

iterm::esc()
{
    printf "${OSC}1337;%b${BEL}" "$@"
}

iterm::setvar()
{   # Usage: iterm::setvar name value

    local name="$1"
    local value="$2"

    value=$(base64 -w 0 <<< "$value") || return

    iterm::esc "SetUserVar=$name=$value"
}

iterm::setbadge()
{   # Usage: iterm::setbadge "string"

    local badge
    badge=$(base64 -w 0 <<< "$@") || return

    iterm::esc "SetBadgeFormat=$badge"
}

iterm::state()
{
    iterm::esc "RemoteHost=$USER@$HOSTNAME"
    iterm::esc "CurrentDir=$PWD"
}

iterm::prompt_prefix()
{
    iterm::esc "D;\$?"
    iterm::state
    iterm::esc "A"

}

iterm::prompt_suffix()
{
    iterm::esc "B"
}

iterm::version()
{
    iterm::esc "ShellIntegrationVersion=1"
}

iterm::state
iterm::version
