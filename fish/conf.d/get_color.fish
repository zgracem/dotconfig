function get_color --description 'Get the partial escape code for a terminal colour'
    switch $argv[1]
        case normal reset
            echo 0
        case '*'
            set_color $argv \
                | string split -n \x1b\[ \
                | string trim -r -cm \
                | string join ';'
    end
end
