function hfind -d "Search fish's command history"
    set -l term (string match -er -- '\A\w' $argv)
    set -l bat_pager "'less -FR -p\"$term\"'"

    if isatty stdout; and in-path bat
        set -l bat_opts --language=fish --style=plain --pager=$bat_pager
        eval "function _at; cat | bat $bat_opts; end"
    else
        eval "function _at; cat | $bat_pager; end"
    end

    # Show results oldest to newest
    set -l hist_opts --reverse

    # Use custom time format
    set -a hist_opts --show-time="# %F %T%n"

    # Do a case-sensitive search only if the search term has uppercase letters
    # (use `-C` to force a case-sensitive search of lowercase strings)
    if string match -rq -- '\A[[:upper:]]|\A\w+[[:upper:]]' $argv
        set -a hist_opts --case-sensitive
    end

    history search $hist_opts $argv | _at
end
