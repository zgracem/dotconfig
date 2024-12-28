function tmux-ssh --wraps ssh --description 'Open an SSH session in a new window'
    set -l cmd "command ssh -t $argv"
    set -l title (string split -f1 . $argv[1])

    new-window --title=$title "$cmd"
end
