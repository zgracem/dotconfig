if command -v gem >/dev/null; then
  case $HOSTNAME in
    Athena*)
      true # Athena should be smart enough not to need this.
      ;;
    web*)
      GEM_HOME="$HOME/.rbenv/versions/2.2.3/lib/ruby/gems/2.2.0"
      ;;
    WS*)
      GEM_HOME="$HOME/.gem/ruby"
      ;;
    Hiroko*)
      GEM_HOME=/usr/local/lib/ruby/gems/2.2.0
      ;;
    *)
      GEM_HOME="$(gem env home 2>/dev/null)" || return
      ;;
  esac

  if [[ -d $GEM_HOME/bin ]] && [[ ! :$PATH: =~ :$GEM_HOME/bin: ]]; then
    PATH=$PATH:"$GEM_HOME/bin"
  fi

  unset -v GEM_HOME

  if declare -f _z_config_symlink >/dev/null; then
    # symlink config file into HOME
    _z_config_symlink "ruby/gemrc"
  fi
fi

if command -v bundle >/dev/null; then
  # Bundler should install binstubs to ~/opt/bin, not ~/bin
  export BUNDLE_BIN="$HOME/opt/bin"
fi

return 0
