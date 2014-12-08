# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/internet.bash
# ------------------------------------------------------------------------------

goclip()
{   # go to the URL on the clipboard

    declare url=$(pbpaste)
    if [[ $url =~ ^http ]]; then
        "$BROWSER" "$(urldecode $url)"
    else
        scold $FUNCNAME "no URL in clipboard"
        return 1
    fi
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
            scold $FUNCNAME "invalid URL"
            return 1
        fi
    else
        # check the clipboard for a URL
        case $OSTYPE in
            darwin*)    pb=$(/usr/bin/pbpaste) ;;
            cygwin)     pb=$(/usr/bin/getclip) ;;
        esac
        if [[ $pb =~ ^http ]]; then
            url="$pb"
        else
            scold $FUNCNAME "no URL found"
            return 1
        fi
    fi

    curl -ILs "$url" \
    | awk '/Location/ { print $2 }'
}


tweet()
{   # post a tweet with TTYtter
    declare status="$@"

    if ! _inPath ttytter; then
        scold $FUNCNAME "ttytter not installed"
        return 1
    elif [[ $# -ne 1 ]]; then
        scold $FUNCNAME "invalid input"
        return 1
    elif [[ ${#status} -gt 140 ]]; then
        scold $FUNCNAME "input > 140 characters"
        return 1
    fi

    ttytter -silent -hold -status="$status"
}
