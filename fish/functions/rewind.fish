function rewind --description 'Copy birth time (et al.) to last-modified time'
    argparse -xe,f n/dry-run h/help v/verbose e/exif f/filename -- $argv
    or return

    command -q gtouch; or return 127

    set -f exit 0

    if set -q _flag_help[1]; or test -z "$argv"
        set -f exit 2
        echo >&2 "Usage: rewind [-e|-f] [-n] [-v] [-h] FILE [FILE ...]"
        set -q _flag_help[1]; and set -f exit 0
    end

    for file in $argv
        set -f mode ctime
        if path is -f $file
            if set -q _flag_exif[1]
                set -f mode exif
                set -f timestamp (exiftool -s3 -CreateDate $file)
                or return
            else if set -q _flag_filename[1]
                set -f mode file
                set -l rblib $XDG_CONFIG_HOME/bin/rewind.rb
                set -f timestamp (ruby -r$rblib -e"puts Rewind.timestamp_from_file('$file')")
                or return
            else
                set -f timestamp (gstat -c "%w" $file)
                or return
            end
            set -l new_time (__rewind_touch_date $timestamp)

            if set -q new_time[1]
                if set -q _flag_dry_run[1]
                    echo [(string upper $mode)] (__rewind_echo_date $timestamp) "==>" $file
                else if gtouch -t "$new_time" $file
                    set -q _flag_verbose[1]
                    and echo (__rewind_echo_date $timestamp) "==>" $file
                else
                    set -f exit 1
                    echo >&2 "failed to touch file:" $file
                end
            else
                set -f exit 1
                echo >&2 "failed to stat file:" $file
            end
        else
            set -f exit 1
            echo >&2 "file not found:" $file
        end
    end

    return $exit
end

# Converts date to "YYYY-MM-DD hh:mm:ss" format for display
function __rewind_echo_date -a date
    __rewind_touch_date "$date" \
        | string replace -r '^(....)(..)(..)(..)(..)\.(..)' "\1-\2-\3 \4:\5:\6"
end

# Converts date to "CCYYMMDDhhmm.ss" format required by gtouch
function __rewind_touch_date -a date
    echo -n "$date" \
        | string split -f1 . \
        | tr -dc "[[:digit:]]" \
        | string replace -r "(..)\$" ".\\1"
end
