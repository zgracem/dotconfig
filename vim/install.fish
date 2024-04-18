#!/usr/bin/env fish

if not set -q XDG_{CONFIG,DATA,CACHE,STATE}_HOME
    echo >&2 "fatal error: XDG basedirs not found in environment!"
    exit 1
end

for dir in $XDG_DATA_HOME $XDG_CACHE_HOME $XDG_STATE_HOME
    mkdir -pv $dir/vim
    or exit
end

set -g VIM $XDG_DATA_HOME/vim

mkdir -pv $VIM/pack/zgm
and ln -sfv $XDG_CONFIG_HOME/vim/data/pack/zgm/start $VIM/pack/zgm/start
or exit
