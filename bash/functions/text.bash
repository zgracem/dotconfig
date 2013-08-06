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
        
        newwin "$EDITOR" "$file"    # see functions/newwin.bash
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

escape()
{   # escape UTF-8 characters into their three-byte format
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions
    printf "\\\x%s" $(printf "$@" | xxd -p -c1 -u)
    [[ -t 1 ]] &&
        echo # print a newline if we're not piping to another program
}

pluralize()
{
    declare num=$1 text=$2

    [[ $num -ge 2 ]] && text+='s'

    echo "$num $text"
}
