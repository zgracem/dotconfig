function __fish_complete_ncurses_subsets
    set -l subsets \
        "SVr1,SVr1 terminfo" \
        "Ultrix,Ultrix terminfo" \
        "HP,HP-UX terminfo" \
        "AIX,AIX extensions" \
        "BSD,4.4BSD terminfo"

    string replace ',' \t"Restrict to " $subsets
end
