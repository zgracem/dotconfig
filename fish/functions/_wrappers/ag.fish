function ag --description 'The Silver Searcher. Like ack, but faster'
    set -p argv --nobreak # don't print a newline between different files
    set -p argv --noheading # print filenames next to matches, not above them
    set -p argv --hidden # search hidden files (.dotfiles)
    set -p argv --ignore=.git
    set -p argv --skip-vcs-ignores # use .ignore, but not .gitignore

    set -p argv \
        --color-match=$__grep_match_color \
        --color-path=$__grep_file_color \
        --color-line-number=$__grep_line_color

    command ag $argv
end
