# -----------------------------------------------------------------------------
# ~zozo/.config/bash/calendar            executed on the first login of the day
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------

# user's personal calendar
calendarFile="$HOME/.local/calendar"

# do we have calendar(1) + a calendar file?
z_require -a calendar -f "$calendarFile" || return

# set up reference files
referenceFile="$HOME/.local/.calendar.last"
checkFile="$HOME/.local/.calendar.today"

# set last-modified date of comparison file to today at midnight
dateToday=$(command date +"%y%m%d0000")
command touch -t "$dateToday" "$checkFile"

# have we done this yet today?
[[ $checkFile -nt $referenceFile ]] || return

# get "this day in history"
calendar -A0 -f "$calendarFile" && {

    # set last-modified date of reference file to today at midnight
    command touch -t "$dateToday" "$referenceFile"

    # delete comparison file
    command rm -f "$checkFile"
}

unset dateToday {calendar,reference,check}File
