#!/usr/bin/env fish

# ln -sfv ../../git/hooks/pre-commit.fish $XDG_CONFIG_HOME/.git/hooks/pre-commit

set -g staged_files (git diff --name-only --staged)

set -g user_agent_files
set -a user_agent_files aria2/aria2.conf
set -a user_agent_files curl/.curlrc
set -a user_agent_files wget/wgetrc
set -a user_agent_files yt-dlp/config

for file in $user_agent_files.m4
    if contains -- $file $staged_files
        make -s -C $XDG_CONFIG_HOME user-agent; or exit
        git add $user_agent_files; or exit
        break
    end
end

if contains -- bin/vsx $staged_files
    make -s -C $XDG_CONFIG_HOME fish/completions/vsx.fish; or exit
    git add fish/completions/vsx.fish; or exit
else if string match -q "bin/*" $staged_files
    make -s -C $XDG_CONFIG_HOME/bin; or exit
end

if string match -q "dircolors/*" $staged_files
    make -s -C $XDG_CONFIG_HOME/dircolors; or exit
end

if string match -q "rbenv/*" $staged_files
    make -s -C $XDG_CONFIG_HOME/rbenv install; or exit
end

if contains -- maestral/.mignore $staged_files
    make -s -C $XDG_CONFIG_HOME/maestral ~/Dropbox/.mignore; or exit
end

true
