# Overrides $__fish_data_dir/functions/fish_greeting.fish
function fish_greeting --description 'Prints a greeting message on startup'
    status is-interactive; or return
    fish-is-newer-than 3.0; or return

    if set -q SSH_CONNECTION
        echo -ns (set_color 08b) '<' (set_color 09a) '°' (set_color 58d) ')))' \
            (set_color a8f) '>' (set_color d9f) '<' (set_color normal)
    else
        echo -ns (set_color f3a) '<' (set_color f28) '°' (set_color f66) ')))' \
            (set_color f80) '>' (set_color fa0) '<' (set_color normal)
    end

    printf " Welcome to %bfish%b, version %b$version%b\\n" \
        (set_color brwhite --italics) (set_color normal) \
        (set_color white) (set_color normal)
end
