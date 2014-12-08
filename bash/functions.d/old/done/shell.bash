# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/shell.bash
# replacements for shell functions
# ------------------------------------------------------------------------------

flatten()
{   # flatten a directory structure
    # https://github.com/ymendel/dotfiles/blob/master/system/functions.bash
    declare targetDir=${1-.}

    find "$targetDir" -type f -mindepth 2 \
        -exec mv {} "$targetDir" \;

    find "$targetDir" -type d -d -depth 1
        -exec rm -rf {} \;
}

pause()
{   # hold for a single keypress

    declare anykey message="$@"

    : ${message:=Press any key to continue...}

    printf "%s" "$message"
    read -s -n1 anykey
    printf "%b" "\n"
}
