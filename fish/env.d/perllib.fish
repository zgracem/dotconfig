# TODO: is this still necessary?
set -gx --path PERLLIB $PERLLIB
set -p PERLLIB $XDG_DATA_HOME/perl
set -p PERLLIB $HOME/opt/share/perl
set PERLLIB (path filter -d $PERLLIB | un1q)

set -gx --path PERL5LIB $PERL5LIB
set -p PERL5LIB $XDG_DATA_HOME/perl5
set -p PERL5LIB $HOME/opt/share/perl5
set PERL5LIB (path filter -d $PERL5LIB | un1q)

export PERL5LIB
