# installed using:
#   unset -v GEMRC GEM_SPEC_CACHE;
#   export GEM_HOME=$HOME/opt/stow/letsencrypt_webfaction/gems;
#   export RUBYLIB=$GEM_HOME/lib;
#   gem2.2 install letsencrypt_webfaction


letsencrypt_webfaction()
(
  export GEMRC="" GEM_SPEC_CACHE=""
  export GEM_HOME=$HOME/opt/stow/letsencrypt_webfaction/gems
  export PATH=$PATH:$GEM_HOME/bin
  export RUBYLIB=$GEM_HOME/lib
  ruby2.2 "$GEM_HOME/bin/letsencrypt_webfaction" "$@"
)
