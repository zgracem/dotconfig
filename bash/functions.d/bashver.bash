bashver()
{   # print bash version if it's not the latest release

    local latest_bash=44
    local this_bash="${BASH_VERSINFO[0]}${BASH_VERSINFO[1]}"

    if (( this_bash < latest_bash )) || [[ ${BASH_VERSINFO[4]} != "release" ]]; then
        printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"
    fi
}
