# Overrides $__fish_data_dir/functions/fish_greeting.fish
function fish_greeting --description 'Prints a greeting message on startup'
    status is-interactive; or return

    if set -q SSH_CONNECTION
        set -f clr 08b 09a 58d a8f d9f
    else
        set -f clr f3a f28 f66 f80 fa0
    end

    set -l fish_parts "<" "°" ")))" ">" "<"

    for n in (seq 1 5)
        set_color $clr[$n]
        echo -ns $fish_parts[$n]
    end

    printf "%b Welcome to %bfish%b, version %b$version%b\\n" \
        (set_color normal) (set_color brwhite --italics) (set_color normal) \
        (set_color white) (set_color normal)
end
