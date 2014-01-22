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

toEpoch()
{   # convert from human units to UNIX epoch (requires GNU date)
    declare input="$1" output

    output="$(date -d "$input" +%s 2>/dev/null)" || {
        printf "%s: invalid date: '%s'" "$FUNCNAME" "$1"
        return 65
    }

    echo "$output"
}

parseEpoch()
{   # convert from UNIX epoch to human units
    declare inputSeconds="$1" outputFormat="$2"

    command date -u $z_dateFlags ${z_GNUdate+@}$inputSeconds +"$outputFormat"
}

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
