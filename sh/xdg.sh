if command -v bundle >/dev/null; then
    export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
    export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundler"
    export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundler"
    mkdir -p "$BUNDLE_USER_CACHE" "$BUNDLE_USER_PLUGIN"
fi

if command -v curl >/dev/null; then
  export CURL_HOME="$XDG_CONFIG_HOME/curl"
fi

if command -v nethack >/dev/null; then
  export NETHACKOPTIONS="@$XDG_CONFIG_HOME/nethack/nethackrc"
fi

if command -v npm >/dev/null; then
    export npm_config_userconfig=$XDG_CONFIG_HOME/npm/npmrc
    mkdir -p "$XDG_DATA_HOME/npm" "$XDG_CACHE_HOME/npm" "$XDG_RUNTIME_DIR/npm"
fi

# You can't use environment variables like $HOME in pip.conf
if command -v pip >/dev/null; then
  export PIP_CACHE_DIR=$XDG_CACHE_HOME/pip
  export PIP_LOG=$HOME/var/log/pip/pip.log
  mkdir -p "$PIP_CACHE_DIR" "$(dirname "$PIP_LOG")"
fi

# Ruby
if command -v ruby >/dev/null; then
  export IRBRC=$XDG_CONFIG_HOME/ruby/irbrc
  if command -v gem >/dev/null; then
    export GEMRC=$XDG_CONFIG_HOME/ruby/gemrc
    export GEM_SPEC_CACHE=$XDG_CACHE_HOME/gem/specs
    mkdir -p "$GEM_SPEC_CACHE"
  fi
  if command -v rubocop >/dev/null; then
    export RUBOCOP_CACHE_ROOT=$XDG_CACHE_HOME
  fi
  if command -v solargraph >/dev/null; then
    export SOLARGRAPH_CACHE=$XDG_CACHE_HOME/solargraph/cache
    mkdir -p "$SOLARGRAPH_CACHE"
  fi
fi

if command -v screen >/dev/null; then
    export SCREENRC=$XDG_CONFIG_HOME/screen/screenrc
    export SCREENDIR=$XDG_RUNTIME_DIR/screen
    mkdir -p "$XDG_RUNTIME_DIR/screen"
fi

command -v tmux >/dev/null && export TMUX_TMPDIR=$XDG_RUNTIME_DIR

command -v wget >/dev/null && export WGETRC=$XDG_CONFIG_HOME/wget/wgetrc
