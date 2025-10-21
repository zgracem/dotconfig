function set_terminal_title --description 'Set the xterm-compatible terminal title'
    argparse -N1 -xw,t,b w/window t/tab b/both -- $argv
    or return

    set -f command "\e]"

    if set -q _flag_window
        set -a command 2
    else if set -q _flag_tab
        set -a command 1
    else # if set -q _flag_both
        set -a command 0
    end

    set -a command ";" "$argv" "\a"

    # Add a Device Control String so tmux passes the escape sequences through
    if test -S (string split -f1 "," "$TMUX")
        set -p command "\ePtmux;\\e"
        set -a command "\e\\"
    end

    echo -ens $command
end
