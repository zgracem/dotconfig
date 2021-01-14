function newwin --description 'Open a command in a new tmux window'
    argparse --name=newwin 't/title=' -- $argv

    if not in-tmux
        eval $argv
        return
    else if not set -q argv[1]
        tmux new-window
        return
    end

    set -q _flag_title
    or set _flag_title (string split -r -m1 / $argv[1])[-1]

    tmux new-window -n $_flag_title (string escape -- $argv)
end
