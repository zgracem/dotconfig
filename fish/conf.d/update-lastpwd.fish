set -gx LAST_PWD_CACHE $XDG_CACHE_HOME/fish/last_pwd
mkdir -p (path dirname $LAST_PWD_CACHE)

function update-lastpwd --on-variable PWD
    set -q fish_private_mode; and return
    echo "$PWD" >$LAST_PWD_CACHE
end
