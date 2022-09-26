function update-lastpwd --on-variable PWD
    set -q fish_private_mode; and return
    echo "$PWD" >$XDG_CACHE_HOME/fish/last_pwd
end
