set -gx MBOX ~/.mail/mbox
set -gx DEAD ~/.mail/dead.letter

if not set -q MAIL
    set -gx MAIL "/var/mail/$USER"
    path is -r $MAIL; or set --erase MAIL
end

set -gx MAILCAPS $XDG_DATA_HOME/mailcap
path is -r $MAILCAPS; or set --erase MAILCAPS
