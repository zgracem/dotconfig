function git-undelete -d "Show git history for a deleted file" -a file
    set -l hashes (git log --max-count=2 --format=%H -- $file)
    or return

    if set -q hashes[2]
        git checkout $hashes[2]"^" -- $file
    else
        echo >&2 "hash not found in git output!"
        # set --show --local hashes >&2
        return 1
    end
end
