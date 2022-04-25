set -q XTERM_VERSION; or exit

set -gx XTERM_PROFILE yes

# For reasons I have yet (2016-06-29) to learn, xterm(1) sessions start with
# POSIXLY_CORRECT set to "y", which messes up a lot of my config files. This
# should detect when that's happening and disable it.
if string match -q y "$POSIXLY_CORRECT"
    set --erase POSIXLY_CORRECT
end
