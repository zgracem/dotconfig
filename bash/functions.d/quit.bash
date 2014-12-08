_inPath osascript || return

quit()
{   # "gently" quit an application

    [[ $# -ge 1 ]] || return 64

    local -a apps=("$@")
    local app

    for app in "${apps[@]}"; do
        osascript -e "quit app '${cmd}'"
    done
}
