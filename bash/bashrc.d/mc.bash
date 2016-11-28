# Midnight Commander

_inPath mc || return

unalias mc 2>/dev/null

mc()
{
  if (( $# > 0 )); then
    local arg; for arg in "$@"; do
      if [[ $arg =~ ^-([fFV]|-(configure-options|datadir(-info)?|version))$ ]]; then
        command mc "$@"
        break
      fi
    done
  fi

  local MC_EDITOR=$EDITOR
  [[ -z $SSH_CONNECTION ]] && MC_EDITOR=${VISUAL%%?( -)-wait}

  # ~/.local/share/mc/skins
  local MC_SKIN="zskin"
  case $Z_SOLARIZED in
    dark)   MC_SKIN="solarized_dark"  ;;
    light)  MC_SKIN="solarized_light" ;;
  esac

  local -a flags_mc=()
  # force xterm mode (for mouse support under tmux)
  flags_mc+=(--xterm)
  # use colourscheme-based skin
  flags_mc+=(--skin=$MC_SKIN)

  if _inScreen || _inTmux; then
    newwin  --title mc \
            EDITOR="$MC_EDITOR" \
            PWD="$PWD" \
            command mc ${flags_mc[*]} "$@"
  else
    # based on /usr/libexec/mc/mc-wrapper.sh
    local MC_PWD_FILE="$XDG_RUNTIME_DIR/mc_pwd_$USER.$$"
    flags_mc+=(--printwd="$MC_PWD_FILE")

    command mc ${flags_mc[*]} "$@"

    if [[ -r $MC_PWD_FILE ]]; then
      local MC_PWD=$(<"$MC_PWD_FILE")
      if [[ -d $MC_PWD ]]; then
        cd "$MC_PWD"
      fi
      command rm -f "$MC_PWD_FILE"
    fi
  fi
}
