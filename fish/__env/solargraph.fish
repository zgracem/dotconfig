in-path solargraph; or exit
set -q XDG_CACHE_HOME; or exit

set -gx SOLARGRAPH_CACHE $XDG_CACHE_HOME/solargraph/cache
mkdir -p $SOLARGRAPH_CACHE
