function ag --description 'The Silver Searcher. Like ack, but faster'
    set -l opts --nobreak # don't print a newline between different files
    set -a opts --noheading # print filenames next to matches, not above them
    set -a opts --hidden #
    set -a opts --ignore=.git # search hidden files (.dotfiles)
    set -a opts --skip-vcs-ignores # use .ignore, but not .gitignore

    set -a opts \
        --color-match=$__grep_match_color \
        --color-path=$__grep_file_color \
        --color-line-number=$__grep_line_color

    command ag $opts $argv
end
