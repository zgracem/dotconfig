_inPath launchctl || return

rlenv()
{ #: - reload OS-wide environment variables (GUI apps will require relaunch)
  local plist="$HOME/Library/LaunchAgents/org.inescapable.environment.plist"

  if [[ -e $plist ]]; then
    launchctl unload "$plist" || return
  else
    ln -sfv "$HOME/.config/misc/${plist##*/}" "${plist%/*}" || return
  fi

  launchctl load "$plist" || return
  printf '%s\n' "Environment reloaded. GUI apps will require relaunch."
}
