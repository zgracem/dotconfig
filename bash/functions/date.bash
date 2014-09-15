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
    local statBin

    if statBin=$(getGNU stat); then
        $statBin -c %Y "$@"
    else
        stat -f %m -t %s "$@"
    fi
}

parseEpoch()
{   # convert from UNIX epoch to human units
    declare inputSeconds="$1" outputFormat="$2"

    command date -u $z_dateFlags ${z_GNUdate+@}$inputSeconds +"$outputFormat"
}
