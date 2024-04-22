function __iterm_request_attention
    argparse 'o/once' 'n/no' 'y/yes' 'f/fireworks' -- $argv
    or return

    if set -q _flag_yes
        set -f value yes
    else if set -q _flag_no
        set -f value no
    else if set -q _flag_once
        set -f value once
    else if set -q _flag_fireworks
        set -f value fireworks
    else # default
        set -f value yes
    end

    __iterm_esc RequestAttention=$value
end
