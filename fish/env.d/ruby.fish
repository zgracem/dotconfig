set -gx RI --format=ansi

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. So link Rubies to Homebrew's OpenSSL (which
# is upgraded):
in-path brew
and set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local/opt/openssl@3"
