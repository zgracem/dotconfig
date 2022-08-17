set -gx RI --format=ansi

# ruby-build installs a non-Homebrew OpenSSL for each Ruby version installed
# and these are never upgraded. So link Rubies to Homebrew's OpenSSL 1.1 (which
# is upgraded):
in-path brew
and set -gx RUBY_CONFIGURE_OPTS "--with-openssl-dir=/usr/local/opt/openssl@1.1"

if in-path solargraph
    set -gx SOLARGRAPH_CACHE $XDG_CACHE_HOME/solargraph/cache
    if path is -d $XDG_CACHE_HOME
        mkdir -p $SOLARGRAPH_CACHE
    else
        set --erase SOLARGRAPH_CACHE
    end
end
