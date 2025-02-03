#!/usr/bin/env fish

# ln -sfv ../../git/hooks/post-receive.fish $XDG_CONFIG_HOME/.git/hooks/post-receive

set -g git_dir (git rev-parse --git-dir)
set -g agefile $git_dir/info/web/last-modified

mkdir -p (path dirname $agefile)
and git for-each-ref \
    --sort=-authordate --count=1 \
    --format='%(authordate:iso8601)' \
    >"$agefile"
