# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/internet.bash
# ------------------------------------------------------------------------------

goclip()
{   # go to the URL on the clipboard
    declare url=$(cat /dev/clipboard)
    if [[ $url =~ ^http ]]; then
        "$BROWSER" "$(urldecode $url)"
    else
        printf "$0: no URL in clipboard\n" 1>&2
        return 1
    fi
}

urlEncodeFile()
{   # URL-encode an entire file; http://stackoverflow.com/a/10797966
    declare targetFile="$1" output

    output="$("$(getPath curl)" -q \
        --silent \
        --output /dev/null \
        --get --data-urlencode "$(cat "$targetFile")" \
        --write-out %{url_effective} \
        "" |
        command cut -c 3-)"

    echo $output
}


follow()
{   # un-shorten a URL
    # http://brettterpstra.com/is-your-url-too-short-try-our-system-free/
    declare pb url

    # take a URL as an argument
    if [[ $1 ]]; then
        if [[ $1 =~ ^http ]]; then
            url="$1"
        else
            printf "%s: invalid URL\n" $FUNCNAME 1>&2
            return 1
        fi
    else
        # check the clipboard for a URL
        case $OSTYPE in
            darwin*)    pb=$(/usr/bin/pbpaste)   ;;
            cygwin)     pb=$(cat /dev/clipboard) ;;
        esac
        if [[ $pb =~ ^http ]]; then
            url="$pb"
        else
            printf "%s: no URL found\n" $FUNCNAME 1>&2
            return 1
        fi
    fi

    curl -ILs "$url" | awk '/Location/ { print $2 }'
}

dataurl()
{   # create a data URL from an image
    # https://github.com/mathiasbynens/dotfiles/blob/master/.functions
    echo "data:image/${1##*.};base64,$(openssl base64 -in "$1")" |
    tr -d "\n"
    echo
}

urlencode()
{   # pure bash URL encoding
    # http://stackoverflow.com/a/10660730
    declare c o encoded

    for ((pos=0; pos<${#1}; pos++)); do
        c=${1:$pos:1}
        case "$c" in
            [-_.~a-zA-Z0-9]) o="$c" ;;
            *)  printf -v o '%%%02x' "'$c" ;;
        esac
        encoded+="$o"
    done

    echo $encoded
}

urldecode()
{   # corresponding decode function
    # http://stackoverflow.com/a/10660730
    declare decoded
    printf -v decoded '%b' "${1//%/\\x}"
    echo $decoded
}

tweet()
{   # post a tweet with TTYtter
    declare status="$@"

    if ! _inPath ttytter.pl; then
        printf "%s: ttytter not installed\n" $FUNCNAME 1>&2
        return 1
    elif [[ $# -ne 1 ]]; then
        printf "%s: invalid input\n" $FUNCNAME 1>&2
        return 1
    elif [[ ${#status} -gt 140 ]]; then
        printf "%s: input > 140 characters\n" $FUNCNAME 1>&2
        return 1
    fi

    ttytter.pl -silent -hold -status="$status"
}

apachelogs()
{
    declare logType

    [[ -d /var/log/apache2 ]] && [[ $STY || $TMUX ]] && {
        for logType in access error; do
            newwin --title ${logType}_log tail -f /var/log/apache2/${logType}_log
        done
    }
}
