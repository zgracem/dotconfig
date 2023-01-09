# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. So link Rubies to Homebrew's OpenSSL (which
# is upgraded):
if command -v brew >/dev/null; then
  export RUBY_CONFIGURE_OPTS="--with-openssl-dir=/usr/local/opt/openssl@3"
fi
