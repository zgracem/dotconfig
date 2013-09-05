# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/text.bash
# for editing and processing text and text files
# ------------------------------------------------------------------------------

_edit()
{   # open a file in the appropriate editor
    declare file="$1"

    [[ $SSH_TTY ]] && {
        # working remotely; use a console editor
        declare windowTitle="$(basename "$EDITOR")"

        # see functions/newwin.bash
        newwin --title "$windowTitle" "$EDITOR" "$file"
        return

    } || {
        # GUI editor
        "$VISUAL" "$file"
    }
}

clip()
{   # copy a plain text file to the clipboard
    # adapted from http://brettterpstra.com/2013/01/15/clip-text-file-a-handy-dumb-service/
    declare textFile="$1"
    if file "$textFile" | grep -q text; then
        cat "$textFile" | pbcopy &&
            printf "Copied '%s' to clipboard\n" "$textFile"
    else
        printf "%s: '%s' is not plain text\n" $FUNCNAME "$textFile" 1>&2
        return 1
    fi
}

rot13()
{   # translate text to or from ROT13
    declare mask='a-zA-Z n-za-mN-ZA-M'

    # file
    [[ -f $1 ]] && {
        cat "$1" | tr $mask
        return
    }

    # string
    [[ -t 0 ]] && {
        echo "$1" | tr $mask
        return
    }

    # standard input
    tr $mask
}

flip()
{
    echo "$@" |
    sed "y/abcdefghijklmnopqrstuvwxyz,'?!./ɐqɔpǝɟƃɥıɾʞlɯuodbɹsʇnΛmxλz',¿¡˙/" |
    rev
}

pluralize()
{   # add trailing 's' where appropriate
    declare count="$1" text="$2"

    [[ $count -ne 1 ]] && text+='s'

    printf "%'d %s\n" "$count" "$text"
}

# -----------------------------------------------------------------------------
# Unicode
# -----------------------------------------------------------------------------

escape()
{   # escape UTF-8 characters into their three-byte format
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions

    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)

    # print a newline if we're not piping to another program
    [[ -t 1 ]] &&
        echo
}

codepoint()
{   # return the Unicode codepoint of a single character
    declare char="$1" hexByte binByte codeBin codeHex

    # get UTF-8 byte sequence
    declare -a hexBytes=($(printf "%s " $(printf "$char" | xxd -p -c1 -u)))

    # convert byte sequence to binary
    for hexByte in ${hexBytes[@]}; do
        printf -v binByte "%08d" $(hex2bin $hexByte) # zero-pad to 8 digits
        codeBin+="${binByte#*0}"    # remove metadata in high bits
    done

    # convert to hexidecimal UTF-16 codepoint
    printf -v codeHex "%04s" "$(bin2hex $codeBin)"

    echo "U+$codeHex"
}

ugrep()
{   # search Unicode character descriptions
    # http://commandlinefu.com/commands/view/7535/

    declare h d searchFile="$(locate -l1 CharName.pm)"

    [[ -r $searchFile ]] || return 69

    egrep -i "^[0-9a-f]{4,} .*$*" "$searchFile" |
    while read h d; do
        /usr/bin/printf "\U$(printf "%08x" 0x$h)\tU+%s\t%s\n" $h "$d"
    done
}
