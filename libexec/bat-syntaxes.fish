#!/usr/bin/env fish

set bat_syntax_dir $XDG_CONFIG_HOME/bat/syntaxes

set repos \
    Phidica/sublime-fish \
    zgracem/terminfo.sublime-syntax \
    zgracem/groff.sublime-syntax

for repo in $repos
    set -l repo_name (basename $repo .sublime-syntax)
    if path is -d $bat_syntax_dir/$repo_name
        cd $bat_syntax_dir/$repo_name
        git pull
    else
        cd $bat_syntax_dir
        git clone git@github.com:$repo.git $repo_name
    end
end

bat cache --build
