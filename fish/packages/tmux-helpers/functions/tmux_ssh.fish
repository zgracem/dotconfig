function tmux_ssh --wraps ssh --description 'Open an SSH session in a new window'
    set -l cmd "command ssh -t $argv"
    set -l title (string split -f1 . $argv[1])

    newwin --title=$title "$cmd"
end
