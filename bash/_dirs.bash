# -----------------------------------------------------------------------------
# ~/.config/bash/_dirs.bash
# -----------------------------------------------------------------------------

# platform-specific
case $PLATFORM in
  mac)
    dir_apps="/Applications"
    dir_downloads="$HOME/Downloads"
    ;;

  windows)
    if [[ -n $USERPROFILE ]]; then
      : "${dir_winhome:="$(cygpath -au "$USERPROFILE")"}"
    else
      case $OSTYPE in
        cygwin) dir_winhome="/cygdrive/c/Users/$USER" ;;
        msys)   dir_winhome="/c/Users/$USER" ;;
      esac
      USERPROFILE="$(cygpath -aw "$dir_winhome")" && export USERPROFILE
    fi
    
    dir_apps="$dir_winhome/Applications"
    dir_downloads="$dir_winhome/Downloads"
    ;;
esac

# machine-specific
case $HOSTNAME in
  WS*)
    dir_downloads="$HOME/tmp"
    ;;
esac

# Leave this unquoted so it expands properly.
# shellcheck disable=SC2086
export ${!dir_*}
