# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/text.bash
# for editing and processing text and text files
# ------------------------------------------------------------------------------

_edit()
{   # open a file in the appropriate editor
    # Usage: _edit FILE[@LINE]

    declare file="$1" lineno_regex='@([[:digit:]]+)$' line

    # get line number (if specified)
    [[ $file =~ $lineno_regex ]] && {
        line="${BASH_REMATCH[1]}"
        file="${file%@*}"
    }

    [[ $SSH_CONNECTION ]] && {
        # working remotely; use a console editor
        declare windowTitle="$(basename "$EDITOR")"

        [[ $EDITOR =~ vim && $line ]] && {
            newwin --title "$windowTitle" "$EDITOR" +$line "$file"
        } || {
            # see functions/newwin.bash
            newwin --title "$windowTitle" "$EDITOR" "$file"
        }

        return
    } || {
        # use a GUI editor

        [[ $VISUAL =~ subl && $line ]] && 
            file="$file:$line" # for Sublime Text

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
        scold $FUNCNAME "'$textFile' is not plain text"
        return 1
    fi
}

pastenote()
{   # paste the contents of the clipboard to a text file
    [[ -d $dir_notes ]] || {
        scold $FUNCNAME "can't find notes directory"
        return 1
    }

    declare fileName="${1:-"Note $(date '+%F at %H.%M.%S')"}"
    declare filePath="$dir_notes/${fileName%.txt}.txt"

    [[ -f $filePath ]] && {
        scold $FUNCNAME "$fileName.txt: already exists"
        return 1
    }

    pbpaste > "$filePath" && echo "$filePath"
}

rot13()
{   # translate text to or from ROT13
    declare mask='a-zA-Z n-za-mN-ZA-M'

    # file
    [[ -f $1 ]] && {
        tr $mask < "$1"
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

