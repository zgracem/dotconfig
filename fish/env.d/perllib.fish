set -gx --path PERLLIB $PERLLIB
set -p PERLLIB $XDG_DATA_HOME/perl
set -p PERLLIB $HOME/opt/share/perl
set PERLLIB (path filter -d $PERLLIB | un1q)

set -gx --path PERLLIB5 $PERLLIB5
set -p PERL5LIB $XDG_DATA_HOME/perl5
set -p PERL5LIB $HOME/opt/share/perl5
set PERLLIB5 (path filter -d $PERLLIB5 | un1q)
