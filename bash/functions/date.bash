# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/date.bash
# ------------------------------------------------------------------------------

_isGNU date && {
    z_GNUdate=true
    z_dateFlags='-d'
} || {
    z_dateFlags='-jf %s'
}

# -----------------------------------------------------------------------------

lmcp()
{   # copy last-modified date of $1 to $2
    declare sourceFile="$1" targetFile="$2"
    command touch -r "$sourceFile" "$targetFile"
}

lm()
{   # return last-modified date of $1 in POSIX seconds
    declare statBin

    statBin=$(getGNU stat) && {
        $statBin -c %Y "$@"
    } || {
        stat -f %m -t %s "$@"
    }
}
