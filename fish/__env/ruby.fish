set -gx RUBYLIB $HOME/lib/ruby

set -gx RI --format=ansi

set -gx IRBRC $XDG_CONFIG_HOME/ruby/irbrc
set -gx PRYRC $XDG_CONFIG_HOME/ruby/pryrc

set -gx RUBOCOP_CACHE_ROOT $XDG_CACHE_HOME

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. So link Rubies to Homebrew's OpenSSL 1.1 (which
# is upgraded):
in-path brew
and set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local/opt/openssl@1.1"
