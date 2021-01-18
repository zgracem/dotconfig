set -gx --path PERLLIB $PERLLIB
test -d ~/share/perl; and set -p PERLLIB ~/share/perl
test -d ~/opt/share/perl; and set -p PERLLIB ~/opt/share/perl
fix-path PERLLIB

set -gx --path PERLLIB5 $PERLLIB5
test -d ~/share/perl5; and set -p PERL5LIB ~/share/perl5
test -d ~/opt/share/perl5; and set -p PERL5LIB ~/opt/share/perl5
fix-path PERLLIB5
