# -----------------------------------------------------------------------------
# Hiroko:~/.local/init.bash
# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "$dir_scripts/loginbanner.sh"
fi

# print bash version (~/.config/bash/functions.d/bashver.bash)
bashver
