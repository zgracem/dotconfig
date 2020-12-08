if [[ -d "$HOME/share/perl5" ]]; then
  export PERL5LIB="$HOME/share/perl5${PERL5LIB:+:$PERL5LIB}"
fi

if [[ -d "$HOME/opt/share/perl5" ]]; then
  export PERL5LIB="$HOME/opt/share/perl5${PERL5LIB:+:$PERL5LIB}"
fi

if [[ -d "$HOME/share/perl" ]]; then
  export PERLLIB="$HOME/share/perl${PERLLIB:+:$PERLLIB}"
fi

if [[ -d "$HOME/opt/share/perl" ]]; then
  export PERLLIB="$HOME/opt/share/perl${PERLLIB:+:$PERLLIB}"
fi
