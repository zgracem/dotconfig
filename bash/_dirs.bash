# -----------------------------------------------------------------------------
# ~/.config/bash/_dirs.bash
# -----------------------------------------------------------------------------

source "$XDG_CONFIG_HOME/user-dirs.dirs"

# platform-specific
case $PLATFORM in
  mac)
    export APPLICATIONS="/Applications"
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
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
    
    export APPLICATIONS="$dir_winhome/Applications"
    XDG_DOWNLOAD_DIR="$dir_winhome/Downloads"
    ;;
esac

# machine-specific
case $HOSTNAME in
  WS*)
    XDG_DOWNLOAD_DIR="$HOME/tmp"
    ;;
esac

# Leave this unquoted so it expands properly.
# shellcheck disable=SC2086
export ${!XDG_*}
