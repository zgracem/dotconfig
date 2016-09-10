# ------------------------------------------------------------------------------
# man pages for all
# ------------------------------------------------------------------------------

# This function will use Terminal.app's x-man-page:// handling if available.
# Set Z_NO_MAN_URL to inhibit this behaviour.

man()
{ # open man page in a new window with a helpful title
  local OPT OPTIND

  if [[ ! -t 1 ]]; then
    # stdout is being redirected somewhere, let it go
    command man "$@"
    return
  fi

  while getopts ':acCdDeEfHiIkKlLmMpPrRStTuVwWXZ7?' OPT; do
    case $OPT in
      [dfhkVwW?])
        command man "$@"
        return
        ;;
      *)
        continue
        ;;
    esac
  done

  # open the new window
  if [[ $TERM_PROGRAM == Apple_Terminal && -z $Z_NO_MAN_URL ]]; then
    # let Terminal.app be clever about this
    open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
    return 0
  ## ZGM revised 2016-06-17 -- better than nothing for now
  elif [[ $TERM_PROGRAM == iTerm.app && -z $Z_NO_MAN_URL ]]; then
    open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
    # open -b com.googlecode.iterm2 "x-man-page://$1${2:+/$2}"
    return 0
  else
    # get a nice title like "printf(1)" or "cron(8)"
    # or fail if man page doesn't exist
    local title
    title=$(_z_mantitle "$@") || return

    if _inScreen; then
      screen -t "$title" man "$@"
    elif _inTmux; then
      tmux new-window -n "$title" "MANLESS= man $*"
    else
      setwintitle "$title"
      command man "$@"
    fi
  fi
}

_z_mantitle()
{
  local manfile title section

  manfile=$(command man -w "$@") || return

  title=${manfile##*/} # strip path
  title=${title%.gz}   # strip extension (if any)

  section=${title##*.} # isolate section
  title=${title%.*}    # remove section

  if [[ $section =~ (.+)(ssl|tcl)$ ]]; then
    section=${BASH_REMATCH[1]}
  elif [[ $section == 3o ]]; then
    section=3
  fi

  printf '%s(%s)' "$title" "$section"
}
