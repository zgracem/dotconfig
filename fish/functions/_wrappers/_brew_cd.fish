# See $__fish_config_dir/functions/_wrappers/brew.fish for enabling code
function _brew_cd -a destination
    switch $destination
        case cache cellar prefix repo repository
            cd (command brew --$argv[1] $argv[2..-1])
        case '*'
            printf >&2 "%s: destination unknown\\n" "$destination"
            return 1
    end
end
