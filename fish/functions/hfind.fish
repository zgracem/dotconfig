# Adds timestamps and syntax highlighting
function hfind -d "Search the command history"
    history search --reverse --show-time="# %F %T%n" --color=always $argv
end
