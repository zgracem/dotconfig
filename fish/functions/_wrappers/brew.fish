if command -sq brew
    function brew --description 'The missing package manager for macOS'
        # Implement `brew cd <location>` to quickly move to Homebrew dirs.
        set -l homebrew_dirs cache caskroom cellar prefix repo repository
        switch $argv[1]
            case cd
                set --erase argv[1] # shift `cd` out of the arguments
                switch $argv[1]
                    case $homebrew_dirs
                        cd (command brew --$argv[1] $argv[2..-1])
                    case '*'
                        printf >&2 "%s: destination unknown\\n" "$destination"
                        return 1
                end
            case '*'
                command brew $argv
        end
    end
end
