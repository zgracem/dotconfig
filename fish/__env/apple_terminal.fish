# Explicitly disable Apple Terminal's session-saving in El Capitan or later.
if string match -q "$TERM_PROGRAM" Apple_Terminal
    set -gx SHELL_SESSION_HISTORY 0
end
