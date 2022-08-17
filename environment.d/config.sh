export CURL_HOME=$XDG_CONFIG_HOME/curl
export npm_config_userconfig="$XDG_CONFIG_HOME/npm/npmrc"
export TMUX_TMPDIR="$XDG_RUNTIME_DIR"
export WGETRC="$XDG_CONFIG_HOME/wget/wgetrc"

if command -v bundle >/dev/null; then
    export BUNDLE_USER_CONFIG="$XDG_CONFIG_HOME/bundle/config"
    export BUNDLE_USER_CACHE="$XDG_CACHE_HOME/bundler"
    export BUNDLE_USER_PLUGIN="$XDG_DATA_HOME/bundler"
fi

# You can't use environment variables like $HOME in pip.conf
if command -v pip >/dev/null; then
  export PIP_CACHE_DIR=$XDG_CACHE_HOME/pip
  export PIP_LOG=$HOME/var/log/pip/pip.log
fi

# Ruby
export IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"
if command -v gem >/dev/null; then
  export GEMRC="${XDG_CONFIG_HOME:-$HOME/.config}/ruby/gemrc"
  export GEM_SPEC_CACHE="${XDG_CACHE_HOME:-$HOME/var/cache}/gem/specs"
fi
if command -v solargraph >/dev/null; then
  export SOLARGRAPH_CACHE="${XDG_CACHE_HOME:-$HOME/var/cache}/solargraph/cache"
  mkdir -p "$SOLARGRAPH_CACHE"
fi
