#!/usr/bin/env fish

# ln -sfv ../../libexec/git-hook-pre-commit.fish $XDG_CONFIG_HOME/.git/hooks/pre-commit

set -g staged_files (git diff --name-only --staged)

set -g user_agent_files
set -a user_agent_files aria2/aria2.conf.m4
set -a user_agent_files curl/.curlrc.m4
set -a user_agent_files wget/wgetrc.m4
set -a user_agent_files yt-dlp/config.m4

for file in $user_agent_files
    if contains -- $file $staged_files
        make -C $XDG_CONFIG_HOME user-agent; or exit
        git add (path change-extension "" $user_agent_files); or exit
        break
    end
end

true
