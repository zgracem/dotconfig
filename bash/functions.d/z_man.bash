# ------------------------------------------------------------------------------
# man pages for all
# ------------------------------------------------------------------------------

# This function will use Terminal.app's x-man-page:// handling if available.
# Set Z_MAN_NO_URL or use `--no-url` to inhibit for the rest of the session.

man()
{ # open man page in a new window with a helpful title
  local OPT OPTIND

  if [[ ! -t 1 ]]; then
    # stdout is being redirected somewhere, let it go
    command "man" "$@"
    return
  fi

  if [[ $1 == --no-url ]]; then
    printf '%s\n' "export Z_MAN_NO_URL=1"
    export Z_MAN_NO_URL=1
    shift
  fi

  while getopts ':acCdDeEfHiIkKlLmMpPrRStTuVwWXZ7?' OPT; do
    case $OPT in
      [dfhkVwW?])
        command "man" "$@"
        return
        ;;
      *)
        continue
        ;;
    esac
  done

  if [[ $1 == */* ]]; then
    # b/c "x-man-page:///usr/share/man/man1/ls.1" doesn't work
    local Z_MAN_NO_URL=1
  fi

  # colourize
  local CSI="$(printf '%b' '\e[')"

  # begin/end "bold" mode -- used for man page headers
  export LESS_TERMCAP_md="${CSI}32m"
  export LESS_TERMCAP_me="${CSI}0m"

  # begin/end "underline" mode -- used to highlight variables
  export LESS_TERMCAP_us="${CSI}33m"
  export LESS_TERMCAP_ue="${CSI}0m"

  # reset everything
  export LESS_TERMEND="${CSI}0m"

  # open the new window
  if [[ $TERM_PROGRAM == Apple_Terminal && -z $Z_MAN_NO_URL ]]; then
    # let Terminal.app be clever about this
    open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
    return 0
  ## ZGM revised 2016-06-17 -- better than nothing for now
  # elif [[ $TERM_PROGRAM == iTerm.app && -z $Z_MAN_NO_URL ]]; then
  #   open -b com.apple.terminal "x-man-page://$1${2:+/$2}"
  #   # open -b com.googlecode.iterm2 "x-man-page://$1${2:+/$2}"
  #   return 0
  else
    # get a nice title like "printf(1)" or "cron(8)"
    # or fail if man page doesn't exist
    local title
    title=$(_z_mantitle "$@") || return

    if _inScreen; then
      screen -t "$title" "man" "$@"
    elif _inTmux; then
      tmux new-window -n "$title" "MANLESS= man $*"
    else
      setwintitle "$title"
      command "man" "$@"
    fi
  fi
}

_z_mantitle()
{
  local manfile title section

  manfile=$(command "man" -w "$@") || return

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
