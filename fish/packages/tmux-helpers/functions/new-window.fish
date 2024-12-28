function new-window --description 'Open a command in a new tmux window'
    argparse --name=new-window 't/title=' -- $argv

    if not in-tmux
        eval $argv
        return
    else if not set -q argv[1]
        tmux new-window
        return
    end

    set -q _flag_title
    or set _flag_title (path basename $argv[1])

    tmux new-window -n $_flag_title (string escape -- $argv)
end
