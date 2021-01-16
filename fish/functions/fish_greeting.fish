# Overrides $__fish_data_dir/functions/fish_greeting.fish
function fish_greeting --description 'Prints a greeting message on startup'
    status is-interactive; or return
    fish_is_newer_than 3.0; or return

    echo -ns (set_color f3a) '<' (set_color f28) '°' (set_color f66) ')))' \
        (set_color f80) '>' (set_color fa0) '<' (set_color normal)

    printf " Welcome to %bfish%b, version %b$version%b\\n" \
        (set_color brwhite --italics) (set_color normal) \
        (set_color white) (set_color normal)
end
