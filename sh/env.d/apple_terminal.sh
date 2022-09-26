# Explicitly disable Apple Terminal's session-saving in El Capitan or later.
if [ -n "$TERM_SESSION_ID" ]; then
  export SHELL_SESSION_HISTORY=0
fi

if [ "$PLATFORM" = mac ]; then
  # Silence "the default shell is zsh" on macOS
  export BASH_SILENCE_DEPRECATION_WARNING=1
fi
