function __fish_complete_infocmp_sorting
    set -l keys \
        "d,database order" \
        "i,terminfo name" \
        "l,long C variable name" \
        "c,termcap name"

    string replace ',' \t"Sort by " $keys
end

function __fish_complete_ncurses_binary
    set -l formats \
        "1,hexadecimal" \
        "2,base64" \
        "3,hex+base64"

    string replace ',' \t $formats
end

function __fish_complete_ncurses_subsets
    set -l subsets \
        "SVr1,SVr1 terminfo" \
        "Ultrix,Ultrix terminfo" \
        "HP,HP-UX terminfo" \
        "AIX,AIX extensions" \
        "BSD,4.4BSD terminfo"

    string replace ',' \t"Restrict to " $subsets
end

complete -c infocmp -f -a "(__fish_complete_ncurses_terminfo)" -d "TERM="

# Comparison options
complete -c infocmp -s d -d "List differing capabilities"
complete -c infocmp -s c -d "List common capabilities"
complete -c infocmp -s n -d "List capabilities in none"
complete -c infocmp -s x -n "__fish_seen_argument -s n" -d "Include BSD capabilities"

# Source listing options
complete -c infocmp -s I -d "List terminfo names"
complete -c infocmp -s L -d "List long C variable names"
complete -c infocmp -s C -d "List termcap names"
complete -c infocmp -s r -n "__fish_seen_argument -s C" -d "Output in termcap form"
complete -c infocmp -s K -n "__fish_seen_argument -s C" -d "Improve BSD compatibility"

# Use= option
complete -c infocmp -s u -d "Describe with 'use='"

# Changing databases
complete -c infocmp -s A -F -a "(__fish_complete_directories)" -d "Database location"
complete -c infocmp -s B -n "__fish_seen_argument -s A" -F -a "(__fish_complete_directories)" -d "Database location"

# Other options
complete -c infocmp -s 0 -d "Print single-row"
complete -c infocmp -s 1 -d "Print single-column"
complete -c infocmp -s a -n "__fish_seen_argument -s F" -d "Retain commented-out capabilities"
complete -c infocmp -s D -n __fish_is_first_arg -d "Print database locations and exit"
complete -c infocmp -s E -d "Format output as C tables"
complete -c infocmp -s e -d "Format output for C initializer"
complete -c infocmp -s F -Fr -d "Compare 2 terminfo files"
complete -c infocmp -s r -n "__fish_seen_argument -s F" -d "Resolve 'use=' references"
complete -c infocmp -s f -n "__fish_seen_argument -s 1" -d "Format complex strings"
complete -c infocmp -s G -n "not __fish_seen_argument -s g" -d "Display constant literals in decimal form"
complete -c infocmp -s g -n "not __fish_seen_argument -s G" -d "Display constant literals in quoted form"
complete -c infocmp -s i -n __fish_is_first_arg -d "Analyze init/reset"
complete -c infocmp -s l -d "Output terminfo names"
complete -c infocmp -s p -d "Ignore padding specifiers"
complete -c infocmp -s Q -x -a "(__fish_complete_ncurses_binary)" -d "Print in binary format"
complete -c infocmp -s q -d "Brief listing"
complete -c infocmp -s R -n "not __fish_seen_argument -s I -s C" -x -a "(__fish_complete_ncurses_subsets)" -d "Restrict output to subset"
complete -c infocmp -s s -n "not __fish_seen_argument -s L -s C" -x -a "(__fish_complete_infocmp_sorting)" -d Sort
complete -c infocmp -s T -d "Remove size restrictions on output"
complete -c infocmp -s t -d "Discard commented-out capabilities"
complete -c infocmp -s U -d "Do not post-process entries"
complete -c infocmp -s V -n __fish_is_first_arg -d "Print ncurses version and exit"
complete -c infocmp -s v -a "(seq 10)" -d "Verbosity"
complete -c infocmp -s w -x -d "Change the output to WIDTH characters"
complete -c infocmp -s W -n "__fish_seen_argument -s w" -d "Wrap long strings"
complete -c infocmp -s x -d "Unknown capabilities are user-defined"
