set -gx RUBYLIB $HOME/lib/ruby

set -gx RI --format=ansi

set -gx IRBRC $XDG_CONFIG_HOME/ruby/irbrc
set -gx PRYRC $XDG_CONFIG_HOME/ruby/pryrc

set -gx RUBOCOP_CACHE_ROOT $XDG_CACHE_HOME
