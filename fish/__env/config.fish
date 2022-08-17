if in-path bundle
    set -gx BUNDLE_USER_CONFIG $XDG_CONFIG_HOME/bundle/config
    set -gx BUNDLE_USER_CACHE $XDG_CACHE_HOME/bundler
    set -gx BUNDLE_USER_PLUGIN $XDG_DATA_HOME/bundler
end

in-path curl; and set -gx CURL_HOME $XDG_CONFIG_HOME/curl

in-path nethack; and set -gx NETHACKOPTIONS "@$XDG_CONFIG_HOME/nethack/nethackrc"

in-path npm; and set -gx npm_config_userconfig $XDG_CONFIG_HOME/npm/npmrc

if in-path pip
    # Can't use environment variables like $HOME in pip.conf
    set -gx PIP_CACHE_DIR $XDG_CACHE_HOME/pip
    set -gx PIP_LOG $HOME/var/log/pip/pip.log
end

# ruby
set -gx IRBRC $XDG_CONFIG_HOME/ruby/irbrc
set -gx PRYRC $XDG_CONFIG_HOME/ruby/pryrc
set -gx GEMRC $XDG_CONFIG_HOME/ruby/gemrc
set -gx GEM_SPEC_CACHE $XDG_CACHE_HOME/gem/specs
in-path rubocop; and set -gx RUBOCOP_CACHE_ROOT $XDG_CACHE_HOME

if in-path screen
    set -gx SCREENRC $XDG_CONFIG_HOME/screen/screenrc
    set -gx SCREENDIR $XDG_RUNTIME_DIR/screen
end

in-path tmux; and set -gx TMUX_TMPDIR $XDG_RUNTIME_DIR

in-path wget; and set -gx WGETRC $XDG_CONFIG_HOME/wget/wgetrc
