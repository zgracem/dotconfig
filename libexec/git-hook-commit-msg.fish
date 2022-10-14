#!/usr/bin/env fish

# ln -sfv ../../libexec/git-hook-commit-msg.fish $XDG_CONFIG_HOME/.git/hooks/commit-msg

function main -a commit_msg_file
    set -l pattern "\S+: .+"
    if command grep -Eq $pattern $commit_msg_file
        exit 0
    else
        echo >&2 "Commit message failed format check!"
        exit 1
    end
end

main $argv
