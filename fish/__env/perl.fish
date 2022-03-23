set -gx --path PERLLIB $PERLLIB
test -d $XDG_DATA_HOME/perl; and set -p PERLLIB $XDG_DATA_HOME/perl
test -d $HOME/opt/share/perl; and set -p PERLLIB $HOME/opt/share/perl
fix-path PERLLIB

set -gx --path PERLLIB5 $PERLLIB5
test -d $XDG_DATA_HOME/perl5; and set -p PERL5LIB $XDG_DATA_HOME/perl5
test -d $HOME/opt/share/perl5; and set -p PERL5LIB $HOME/opt/share/perl5
fix-path PERLLIB5
