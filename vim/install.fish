#!/usr/bin/env fish

if not set -q XDG_CONFIG_HOME XDG_DATA_HOME
    echo >&2 "fatal error: XDG basedirs not found in environment!"
    exit 1
end

set VIM $XDG_DATA_HOME/vim

mkdir -pv $VIM/pack/zgm; and cd $VIM/pack/zgm; or exit
ln -sfv $XDG_CONFIG_HOME/vim/data/pack/zgm/start ./start; or exit

mkdir -pv $VIM/pack/tpope/start; and cd $VIM/pack/tpope/start; or exit
set tpope_pkgs characterize commentary repeat speeddating unimpaired
for pkg in $tpope_pkgs
    path is -d $pkg; and continue
    git submodule add "git@github.com:tpope/vim-$pkg.git" "./$pkg"; or exit
end

mkdir -pv $VIM/pack/easymotion/start; and cd $VIM/pack/easymotion/start; or exit
if not path is -d easymotion
    git submodule add git@github.com:easymotion/vim-easymotion.git ./easymotion; or exit
end

mkdir -pv $VIM/pack/elzr/start; and cd $VIM/pack/elzr/start; or exit
if not path is -d json
    git submodule add git@github.com:elzr/vim-json.git ./json; or exit
end
