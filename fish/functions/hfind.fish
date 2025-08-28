# Adds timestamps and syntax highlighting
function hfind -d "Search the command history"
    command -q bat; and set -fx PAGER bat -pp -lfish
    history search --reverse --show-time="# %F %T%n" $argv
end
