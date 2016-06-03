if type -P gem &>/dev/null; then
  case $HOSTNAME in
    Athena|*webfaction*)
      GEM_HOME=$HOME/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0
      ;;
    *.atco.com)
      GEM_HOME=$HOME/.gem/ruby
      ;;
    Hiroko)
      GEM_HOME=/usr/local/lib/ruby/gems/2.2.0
      ;;
    *)
      GEM_HOME=$(gem env home 2>/dev/null) || return
      ;;
  esac

  if [[ -d $GEM_HOME/bin ]] && [[ ! :$PATH: =~ :$GEM_HOME/bin: ]]; then
    PATH=$PATH:"$GEM_HOME/bin"
  fi

  unset -v GEM_HOME
fi
