function __fish_complete_tput_cmds
    set -l cmds \
        'init,Initialize the terminal' \
        'longname,Output the long name of the terminal' \
        'reset,Reset the terminal'

    string replace ',' \t $cmds
    __fish_complete_ncurses_caps
end

complete -c tput --no-files
complete -c tput -a "(__fish_complete_tput_cmds)"
complete -c tput -s V -n __fish_is_first_arg -d 'Report the ncurses version and exit'
complete -c tput -s S -d 'Accept capabilities from stdin'
complete -c tput -s T -x -a "(__fish_complete_ncurses_terminfo)" -d 'Specify terminal type'
