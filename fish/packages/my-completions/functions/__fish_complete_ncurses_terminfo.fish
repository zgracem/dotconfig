# Used by `infocmp`, `tic`, and `tput`
function __fish_complete_ncurses_terminfo
    set -l terminfo_dirs $TERMINFO_DIRS
    if test -z "$terminfo_dirs"
        set terminfo_dirs $XDG_DATA_HOME/terminfo # ~/.local/share
        set -a terminfo_dirs $HOMEBREW_PREFIX/opt/ncurses/share/terminfo # Homebrew
        set -a terminfo_dirs /usr/share/terminfo # OS-supplied
    end
    set -l all_ti_files $terminfo_dirs/*/*

    test (count $all_ti_files) -gt 0; or return

    path basename $all_ti_files | path sort -u | string match -v '*+*'
end
