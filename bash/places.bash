# -----------------------------------------------------------------------------
# ~zozo/.config/bash/places
# say hello: printf "zozo\x40inescapable\x2eorg"
# -----------------------------------------------------------------------------
# variables
# -----------------------------------------------------------------------------

# universal
dir_config="${HOME}/.config"
dir_local="${HOME}/.local"

dir_dropbox="${HOME}/Dropbox"
dir_poems="${dir_dropbox}/Writing/p"
dir_proj="${dir_dropbox}/Projects"

dir_mybin="${HOME}/bin"
dir_mytmp="${HOME}/tmp"
dir_scratch="${dir_mytmp}/_scratch"
dir_notes="${HOME}/txt"
dir_scripts="${HOME}/scripts"
dir_dev="${dir_scripts}/dev"

# platform-specific
case $OSTYPE in
    darwin*)
        dir_apps="/Applications"
        dir_desktop="${HOME}/Desktop"
        dir_docs="${HOME}/Documents"
        dir_downloads="${HOME}/Downloads"
        dir_music="${HOME}/Music/iTunes/iTunes Media/Music"
        dir_prefs="${HOME}/Library/Preferences"
        dir_drive="/Volumes/SILVER"

        if _inPath brew; then
            : ${HOMEBREW_PREFIX:=$(brew --prefix)}
            export HOMEBREW_PREFIX
        fi
        ;;

    cygwin)
        : ${dir_desktop:="$(cygpath --desktop)"}
        : ${dir_docs:="$(cygpath --mydocs)"}
        : ${dir_winhome:="$(cygpath -au "$USERPROFILE")"}
        dir_downloads="${dir_docs}/Downloads"
        dir_dropbox="${dir_docs}/Dropbox"
        ;;
esac

# machine-specific
case $HOSTNAME in
    Erato)
        dir_docs="${dir_dropbox}/Documents"
        ;;

    ws144966)
        dir_apps="${dir_winhome}/Applications"
        dir_downloads="${HOME}/tmp"
        dir_dropbox="${HOME}/Dropbox"
        ;;

    WTL2)
        dir_music="${dir_docs}/My Music/iTunes/iTunes Media/Music"
        ;;
esac

export ${!dir_*}

# -----------------------------------------------------------------------------
# go()
# -----------------------------------------------------------------------------

go()
{
    declare name="$1" place checkvar child
    declare alias_file="${dir_config}/bash/places/go_aliases"

    if [[ $name =~ / ]]; then
        child="${name#*/}"
        name="${name%%/*}"
    fi

    # first, see if we're trying to call a variable directly
    checkvar="dir_${name}"

    if [[ -n ${!checkvar} ]]; then
        place="${!checkvar}"
    else
        # see if there's an alias with that name
        place="$(sed -nE "s/^${name}\t(.+)$/\1/p" "$alias_file")"
        eval "place=\"${place}\""
    fi

    # any luck?
    if [[ -z $place ]]; then
        scold "${FUNCNAME}: ${name}: not found"
        return 1
    fi

    # make sure that directory exists & is accessible
    if [[ ! -d $place ]]; then
        scold "${FUNCNAME}: ${place}: not a directory"
        return 1
    elif [[ ! -r $place ]]; then
        scold "${FUNCNAME}: ${place}: not readable"
        return 1
    else
        cd "${place}${child:+/$child}"
    fi
}
