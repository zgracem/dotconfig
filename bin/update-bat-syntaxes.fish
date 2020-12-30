#!/usr/bin/env fish

set syntax_dir $XDG_CONFIG_HOME/bat/syntaxes

for syntax_file in $syntax_dir/**/*.sublime-syntax
    cd (dirname $syntax_file)
    git pull; or exit
end

bat cache --build
