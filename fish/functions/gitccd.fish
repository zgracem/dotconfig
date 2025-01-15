# Automatically clones `git@github.com:username/repository.git` into the subdir
# `username/repository/`, creating `username/` first if necessary, then changes
# into the new directory.
function gitccd -d "clone a repo and cd into it"
    set -f repo_url $argv[1]
    set -f git_parent_dir $argv[2]
    set -q git_parent_dir; or set -f git_parent_dir ~/src/github.com

    if string match -rq '^[\w-]+/[\w-]+$' $repo_url
        set -f repo_url git@github.com:$repo_url.git
    end

    set -f repo_dir (string match -rg '(?<=github\.com[:/])([^/]+/.+?)(?=\.git|\Z)' $repo_url)

    if set -q repo_dir[1]
        cd ~/src/github.com
        and mkdir -p (path dirname $repo_dir)
        and git clone $repo_url $repo_dir
        and cd $repo_dir
    else
        echo >&2 "couldn't parse repository from $repo_url" \($repo_dir\)
        return 1
    end
end
