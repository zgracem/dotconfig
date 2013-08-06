# -----------------------------------------------------------------------------
# ~zozo/.config/bash/calendar            executed on the first login of the day
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# user's personal calendar
calUserFile="$HOME/.calendar"

# do we have calendar(1) + a calendar file?
if calBin=$(getPath calendar) && [[ -e $calUserFile ]]; then
    calToday=$(command date +"%y%m%d0000")

    # set up reference files
    calRefFile="$HOME/share/calendar/.last"
    calCheckFile="$HOME/share/calendar/.today"

    command touch -t "$calToday" "$calCheckFile"

    # have we done this yet today?
    [[ $calCheckFile -nt $calRefFile ]] && {
        "$calBin" -A0 -f "$calUserFile" && {
            command touch -t "$calToday" "$calRefFile"
            command rm "$calCheckFile"
        }
    }

fi

unset calUserFile calBin calToday calRefFile calCheckFile