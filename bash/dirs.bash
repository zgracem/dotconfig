# -----------------------------------------------------------------------------
# ~/.config/bash/dirs.bash
# -----------------------------------------------------------------------------

# universal
dir_config="$HOME/.config"
dir_local="$HOME/.local"

dir_dropbox="$HOME/Dropbox"
dir_scratch="$HOME/tmp/_scratch"

dir_scripts="$HOME/scripts"
dir_dev="$dir_scripts/dev"
dir_defunct="$dir_dropbox/src/_defunct"
dir_cache="$HOME/var/cache"

dir_bashlib="$HOME/lib"
dir_howto="$HOME/txt/howto"
dir_vsmm="$dir_dropbox/www/vsmm"

# platform-specific
case $OSTYPE in
    darwin*)
        dir_apps="/Applications"
        dir_desktop="$HOME/Desktop"
        dir_docs="$HOME/Documents"
        dir_downloads="$HOME/Downloads"
        dir_music="$HOME/Music/iTunes/iTunes Media/Music"
        ;;

    cygwin)
        : ${dir_desktop:="$(cygpath --desktop)"}
        : ${dir_docs:="$(cygpath --mydocs)"}
        dir_downloads="$dir_docs/Downloads"
        dir_dropbox="$dir_docs/Dropbox"

        if [[ -n $USERPROFILE ]]; then
            : ${dir_winhome:="$(cygpath -au "$USERPROFILE")"}
        else
            dir_winhome="/cygdrive/c/Users/$USER"
        fi
        ;;
esac

# machine-specific
case $HOSTNAME in
    Erato)
        dir_docs="$dir_dropbox/Documents"
        ;;

    *.atco.com)
        dir_apps="$dir_winhome/Applications"
        dir_downloads="$HOME/tmp"
        dir_dropbox="$HOME/Dropbox"
        ;;

    WTL2)
        dir_music="$dir_docs/My Music/iTunes/iTunes Media/Music"
        ;;

    Pallas)
        dir_downloads="$dir_winhome/Downloads"
        ;;
esac

export ${!dir_*}

# # bash-completion v1
# if [[ -z $BASH_COMPLETION_DIR ]]; then
#     for BASH_COMPLETION_DIR in /{usr/local/,}etc/bash_completion.d; do
#         if [[ -d $BASH_COMPLETION_DIR ]]; then
#             export BASH_COMPLETION_DIR
#             break
#         else
#             unset BASH_COMPLETION_DIR
#         fi
#     done
# fi
