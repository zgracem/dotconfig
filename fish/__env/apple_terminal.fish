# Explicitly disable Apple Terminal's session-saving in El Capitan or later.
if set -q TERM_SESSION_ID
    set -gx SHELL_SESSION_HISTORY 0
end
