function brew --description 'The missing package manager for macOS'
    in-path brew; or return 127

    switch $argv[1]
        case cd
            set -e argv[1]
            switch $argv[1]
                case cache cellar prefix repo repository
                    cd (command brew --$argv[1] $argv[2..-1])
                case '*'
                    printf >&2 "%s: destination unknown\\n" "$destination"
                    return 1
            end
        case '*'
            command brew $argv
    end
end
