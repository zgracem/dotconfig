function __iterm_request_attention
    argparse 'o/once' 'x/stop' 'r/repeat' -- $argv
    or return

    if set -q _flag_repeat
        set -f value yes
    else if set -q _flag_stop
        set -f value no
    else
        set -f value once
    end

    __iterm_esc RequestAttention=$value
end
