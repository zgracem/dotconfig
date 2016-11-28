# -----------------------------------------------------------------------------
# ~/.config/bash/_dirs.bash
# -----------------------------------------------------------------------------

dir_config="${XDG_CONFIG_HOME:-$HOME/.config}"

dir_dropbox="$HOME/Dropbox"
dir_scripts="$HOME/scripts"

# platform-specific
case $PLATFORM in
  mac)
    dir_apps="/Applications"
    dir_downloads="$HOME/Downloads"
    ;;

  windows)
    if [[ -n $USERPROFILE ]]; then
      : ${dir_winhome:="$(cygpath -au "$USERPROFILE")"}
    else
      case $OSTYPE in
        cygwin) dir_winhome="/cygdrive/c/Users/$USER" ;;
        msys)   dir_winhome="/c/Users/$USER" ;;
      esac
      export USERPROFILE="$(cygpath -aw "$dir_winhome")"
    fi
    
    dir_downloads="$dir_winhome/Downloads"
    dir_dropbox="$dir_winhome/Dropbox"
    ;;
esac

# machine-specific
case $HOSTNAME in
  WS*|Pallas*)
    dir_apps="$dir_winhome/Applications"
    ;;&
  WS*)
    dir_downloads="$HOME/tmp"
    dir_dropbox="$HOME/Dropbox"
    ;;
esac

export ${!dir_*}
