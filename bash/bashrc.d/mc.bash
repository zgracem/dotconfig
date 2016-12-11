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

  # force xterm mode (for mouse support under tmux)
  set -- --xterm "$@"
  # use colourscheme-based skin
  set -- --skin=$MC_SKIN "$@"

  if _inScreen || _inTmux; then
    newwin  --title mc \
            EDITOR="$MC_EDITOR" \
            PWD="$PWD" \
            command mc "$@"
  else
    # based on /usr/libexec/mc/mc-wrapper.sh
    local MC_PWD_FILE="$XDG_RUNTIME_DIR/mc_pwd_$USER.$$"
    set -- --printwd="$MC_PWD_FILE" "$@"

    command mc "$@"

    if [[ -r $MC_PWD_FILE ]]; then
      local MC_PWD=$(<"$MC_PWD_FILE")
      if [[ -d $MC_PWD ]]; then
        cd "$MC_PWD"
      fi
      command rm -f "$MC_PWD_FILE"
    fi
  fi
}
