return

### ZGM disabled 2016-06-03 -- need to decide if this is worth it

[[ $TERM_PROGRAM == iTerm.app ]] || return

# if ! (( ITERM_VERSINFO[0] >= 2 )) && (( ITERM_VERSINFO[1] >= 9 )); then
#     return
# fi

iterm::esc()
{
    printf "${OSC}1337;%s${BEL}" "$@"
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
    printf "${OSC}133;D;\$?${BEL}"
    iterm::state
    printf "${OSC}133;A${BEL}"

}

iterm::prompt_suffix()
{
    printf "${OSC}133;B${BEL}"
}

iterm::version()
{
    iterm::esc "ShellIntegrationVersion=1"
}

iterm::state
iterm::version

# -----------------------------------------------------------------------------

