# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/debug.bash
# handy functions for debugging and development
# ------------------------------------------------------------------------------

xtrace()
{   # toggle xtrace
    if _optSet xtrace; then
        set +o xtrace
    else
        set -o xtrace
    fi
}

screensize()
{   # output the screen dimensions

    local x=$'\xc3\x97'
    local w="${COLUMNS:-$(tput cols)}"
    local h="${LINES:-$(tput lines)}"

    printf '%d %b %d\n' "$w" "$x" "$h"
}
