# Explicitly disable Apple Terminal's session-saving in El Capitan or later.
if string match -q Apple_Terminal "$TERM_PROGRAM"
    set -gx SHELL_SESSION_HISTORY 0
end

if is-macos
    # Silence "the default shell is zsh" on macOS
    set -gx BASH_SILENCE_DEPRECATION_WARNING 1
end