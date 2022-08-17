export IRBRC="$XDG_CONFIG_HOME/ruby/irbrc"

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. So link Rubies to Homebrew's OpenSSL 1.1 (which
# is upgraded):
if command -v brew >/dev/null; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@1.1"
fi
