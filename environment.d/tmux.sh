[ "$PLATFORM" = "mac" ] || return

MACOS_VERSION=$(sw_vers -productVersion | cut -d. -f2)

if command -v tmux >/dev/null && [ $((MACOS_VERSION)) -ge 12 ]; then
  # kqueue is broken on macOS Sierra, but tmux 2.2 doesn't turn it off properly
  # >> github.com/tmux/tmux/issues/475
  export EVENT_NOKQUEUE=1
fi
