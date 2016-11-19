# -----------------------------------------------------------------------------
# ~/.config/bash/_dirs.bash
# -----------------------------------------------------------------------------

dir_config="$HOME/.config"
dir_local="$HOME/.local"

dir_bashlib="$HOME/lib/bash"
dir_dropbox="$HOME/Dropbox"
dir_howto="$HOME/txt/howto"
dir_scripts="$HOME/scripts"

# platform-specific
case $PLATFORM in
  mac)
    dir_apps="/Applications"
    dir_desktop="$HOME/Desktop"
    dir_docs="$HOME/Documents"
    dir_downloads="$HOME/Downloads"
    dir_music="$HOME/Music/iTunes/iTunes Media/Music"
    ;;

  windows)
    : ${dir_desktop:="$(cygpath --desktop)"}
    : ${dir_docs:="$(cygpath --mydocs)"}
    dir_downloads="$dir_docs/Downloads"

    if [[ -n $USERPROFILE ]]; then
      : ${dir_winhome:="$(cygpath -au "$USERPROFILE")"}
    else
      if [[ $OSTYPE == cygwin ]]; then
        dir_winhome="/cygdrive/c/Users/$USER"
      elif [[ $OSTYPE == msys ]]; then
        dir_winhome="/c/Users/$USER"
      fi
      export USERPROFILE="$(cygpath -aw "$dir_winhome")"
    fi
    
    dir_dropbox="$dir_winhome/Dropbox"
    ;;
esac

# machine-specific
case $HOSTNAME in
  Erato*)
    dir_docs="$dir_dropbox/Documents"
    ;;

  WS*)
    dir_apps="$dir_winhome/Applications"
    dir_downloads="$HOME/tmp"
    dir_dropbox="$HOME/Dropbox"
    ;;

  Pallas*)
    dir_downloads="$dir_winhome/Downloads"
    ;;
esac

export ${!dir_*}
