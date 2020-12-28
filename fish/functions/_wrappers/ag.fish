function ag --description 'The Silver Searcher. Like ack, but faster'
    set -l opts --nobreak --noheading
    set -a opts --color-path="34" --color-line-number="36" --color-match="4;95"
    set -a opts --hidden --ignore=.git --skip-vcs-ignores

    command ag $opts $argv
end
