# -----------------------------------------------------------------------------
# ~zozo/.config/bash/dirs.bash
# -----------------------------------------------------------------------------

# universal
dir_config="${HOME}/.config" #debug
# dir_config="$HOME/Dropbox/inbox/newconfig"
dir_local="${HOME}/.local"

dir_dropbox="${HOME}/Dropbox"
dir_proj="${dir_dropbox}/Projects"

dir_mybin="${HOME}/bin"
dir_mytmp="${HOME}/tmp"
dir_scratch="${dir_mytmp}/_scratch"

dir_scripts="${HOME}/scripts"
dir_dev="${dir_scripts}/dev"
dir_notes="${HOME}/txt"

# platform-specific
case $OSTYPE in
    darwin*)
        dir_apps='/Applications'
        dir_desktop="${HOME}/Desktop"
        dir_docs="${HOME}/Documents"
        dir_downloads="${HOME}/Downloads"
        dir_music="${HOME}/Music/iTunes/iTunes Media/Music"
        dir_prefs="${HOME}/Library/Preferences"
        dir_drive='/Volumes/SILVER'

        if type -P brew &>/dev/null; then
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
    Minerva)
        dir_old="/Volumes/Minerva HD"
        dir_oldhome="${dir_old}${HOME}"
        ;;

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
