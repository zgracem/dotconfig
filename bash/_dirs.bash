#!/bin/sh

# XDG base directories
[ -z "$XDG_CONFIG_HOME" ] && export XDG_CONFIG_HOME="$HOME/.config"
[ -z "$XDG_DATA_HOME" ] && export XDG_DATA_HOME="$HOME/.local/share"
[ -z "$XDG_CACHE_HOME" ] && export XDG_CACHE_HOME="$HOME/var/cache"
[ -z "$XDG_RUNTIME_DIR" ] && export XDG_RUNTIME_DIR="$HOME/var/run"

# XDG user directories
source "$XDG_CONFIG_HOME/user-dirs.dirs"

# platform-specific
case $PLATFORM in
  mac)
    XDG_DOWNLOAD_DIR="$HOME/Downloads"
    ;;

  windows)
    if [[ -n $USERPROFILE ]]; then
      : "${user_profile:="$(cygpath -au "$USERPROFILE")"}"
    else
      case $OSTYPE in
        cygwin) user_profile="/cygdrive/c/Users/$USER" ;;
        msys)   user_profile="/c/Users/$USER" ;;
      esac
      USERPROFILE="$(cygpath -aw "$user_profile")" && export USERPROFILE
    fi

    XDG_DESKTOP_DIR="$user_profile/Desktop"
    XDG_DOCUMENTS_DIR="$user_profile/My Documents"
    XDG_DOWNLOAD_DIR="$user_profile/Downloads"
    XDG_MUSIC_DIR="$user_profile/Music"
    XDG_PUBLICSHARE_DIR="$(cygpath -au "$PUBLIC")"
    XDG_VIDEOS_DIR="$user_profile/Videos"

    unset -v user_profile

    # machine-specific
    case $HOSTNAME in
    WS*)
        XDG_DOCUMENTS_DIR="$(cygpath -au "$HOMESHARE\\My Documents")"
        XDG_DOWNLOAD_DIR=~/tmp
        XDG_MUSIC_DIR="$XDG_DOCUMENTS_DIR/My Music"
        XDG_PICTURES_DIR="$XDG_DOCUMENTS_DIR/My Pictures"
        XDG_VIDEOS_DIR="$XDG_DOCUMENTS_DIR/My Videos"
        ;;
    esac
    ;;

  linux)
    XDG_DESKTOP_DIR=~/.desktop
    XDG_DOCUMENTS_DIR=~/doc
    XDG_DOWNLOAD_DIR=~/tmp
    ;;
esac

# Leave this unquoted so it expands properly.
# shellcheck disable=SC2086
export ${!XDG_*}
