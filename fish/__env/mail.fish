set -gx MBOX ~/.mail/mbox
set -gx DEAD ~/.mail/dead.letter
mkdir -p (dirname $MBOX)

if not set -q MAIL
    set -gx MAIL "/var/mail/$USER"
    test -r $MAIL; or set --erase MAIL
end

set -gx MAILCAPS $XDG_DATA_HOME/mailcap
test -d $MAILCAPS; or set --erase MAILCAPS
