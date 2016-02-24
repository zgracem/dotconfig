[[ $TERM_PROGRAM == iTerm.app ]] || return

### ZGM disabled 2015-10-02: I don't use iTerm much anymore and
#   I'm definitely not using old versions of it, so.

# if [[ -z $ITERM_VERSINFO ]]; then
    # # find the app
    # ps_re='^/.+/iTerm\.app[[:>:]]'
    # ps_output=$(command ps -T -o comm= | head -n1)

    # if [[ $ps_output =~ $ps_re ]]; then
    #     iterm_app=${BASH_REMATCH[0]}
    # else
    #     for proc in $(command ps -x -o comm= | grep '/iTerm\.app/' | sort -u); do
    #         if [[ $proc =~ $ps_re ]]; then
    #             iterm_app=${BASH_REMATCH[0]}
    #             break
    #         fi
    #     done
    # fi

    # IFS=. read -a ITERM_VERSINFO < <(/usr/libexec/PlistBuddy \
    #     -c 'Print :CFBundleShortVersionString' \
    #     "$iterm_app/Contents/info.plist")

    # unset -v proc ps_re ps_output iterm_app
# fi

# -----------------------------------------------------------------------------

if ! (( ITERM_VERSINFO[0] >= 2 )) && (( ITERM_VERSINFO[1] >= 9 )); then
    return
fi

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

