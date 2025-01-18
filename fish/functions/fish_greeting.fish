# Overrides $__fish_data_dir/functions/fish_greeting.fish
function fish_greeting --description 'Prints a greeting message on startup'
    status is-interactive; or return

    if set -q SSH_CONNECTION
        set -gx fish_parts ">" "<" "(((" "°" ">"
        set -gx fish_colours 08b 09a 58d a8f d9f
    else
        set -gx fish_parts "<" "°" ")))" ">" "<"
        set -gx fish_colours f3a f28 f66 f80 fa0
    end

    tput el1 # clear to beginning of line
    tput cr  # carriage return

    functions -q motd; and motd; and return

    for n in (seq (count $fish_parts))
        set_color $fish_colours[$n]
        echo -ns $fish_parts[$n]
    end

    printf "%b Welcome to %bfish%b, version %b$version%b\\n" \
        (set_color normal) (set_color brwhite --italics) (set_color normal) \
        (set_color white) (set_color normal)
end
