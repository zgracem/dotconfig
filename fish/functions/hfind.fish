# Adds timestamps and syntax highlighting
function hfind -d "Search the command history"
    # Discard potential --options (but pass them through to `history`)
    set -l query (string match -er -- '\A\w' $argv)
    set -l hist_opts

    # Set up pager
    set -lx PAGER less --quit-if-one-screen --RAW-CONTROL-CHARS --pattern="$query"

    if isatty stdout
        eval "function _hpager; cat | fish_indent --ansi | $PAGER; end"
    else
        eval "function _hpager; cat; end"
    end

    # Use custom time format
    set -a hist_opts --show-time="# %F %T%n"

    # Do a case-sensitive search only if the search query has uppercase letters
    # (use `-C` to force a case-sensitive search of lowercase strings)
    if string match -rq -- "\A\w*[[:upper:]]" $argv
        set -a hist_opts --case-sensitive
    end

    history search $hist_opts $argv | _hpager
end
