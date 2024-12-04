function __fish_complete_tic_entries
    __fish_complete_ncurses_terminfo
    return
    # set -l token (commandline --cut-at-cursor --current-token)
    # set -l comps

    # if string match -q "*," -- $token
    #     set -a comps $token(__fish_complete_ncurses_terminfo)
    # else if string match -q "*/*" -- $token
    #     set -a comps (__fish_complete_files $token)
    # else
    #     set -a comps (__fish_complete_files $token)
    # end

    # if set -q comps[1]
    #     printf "%s\t\n" $comps
    # end
end

complete -c tic -s 0 -d "Print single-row"
complete -c tic -s 1 -d "Print single-column"
complete -c tic -s a -d "Retain commented-out capabilities"
complete -c tic -s C -d "Translate entries to termcap format"
complete -c tic -s c -d "Check for errors only"
complete -c tic -s D -n __fish_is_first_arg -d "Print database locations and exit"
complete -c tic -s e -F -r -a "(__fish_complete_tic_entries)" -d "Only translate/compile for these entries"
complete -c tic -s f -d "Format complex strings"
complete -c tic -s G -n "not __fish_seen_argument -s g" -d "Display constant literals in decimal form"
complete -c tic -s g -n "not __fish_seen_argument -s G" -d "Display constant literals in quoted form"
complete -c tic -s I -d "Translate entries to terminfo format"
complete -c tic -s K -n "__fish_seen_argument -s C" -d "Translate entries to termcap format with BSD syntax"
complete -c tic -s L -d "Translate entries to full terminfo format"
complete -c tic -s N -d "Disable smart defaults for source translation"
complete -c tic -s o -F -a "(__fish_complete_directories)" -d "Output to database location"
complete -c tic -s q -d "Brief listing"
complete -c tic -s Q -x -a "(__fish_complete_tic_binary)" -d "Print in binary format"
complete -c tic -s R -x -a "(__fish_complete_tic_subsets)" -d "Restrict translation to subset"
complete -c tic -s r -d "Resolve 'use=' references"
complete -c tic -s s -d "Print summary statistics"
complete -c tic -s T -d "Remove size restrictions on output"
complete -c tic -s t -d "Discard commented-out capabilities"
complete -c tic -s U -d "Do not post-process entries"
complete -c tic -s V -n __fish_is_first_arg -d "Print ncurses version and exit"
complete -c tic -s v -a "(seq 10)" -d Verbosity
complete -c tic -s w -x -d "Change the output to WIDTH characters"
complete -c tic -s W -n "__fish_seen_argument -s w" -d "Wrap long strings"
complete -c tic -s x -d "Unknown capabilities are user-defined"
