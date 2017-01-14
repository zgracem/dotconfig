_inPath launchctl || return

rlenv()
{ # reload OS-wide environment variables (GUI apps will require restart)
  local plist="$HOME/Library/LaunchAgents/org.inescapable.environment.plist"

  if [[ ! -e $plist ]]; then
    ln -sv "$HOME/Dropbox/.config/misc/${plist##*/}" || return
  else
    launchctl unload "$plist" || return
  fi

  launchctl load "$plist" || return
}
