function git-browse -d "Print the URL of the repo's GitHub page"
    set -l origin (git remote get-url --all origin)
    or return

    string replace 'git@github.com:' 'https://github.com/' $origin \
        | string replace -r '\.git$' ''
end
