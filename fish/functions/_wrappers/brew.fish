function brew --description 'The missing package manager for macOS'
    command -q brew; or return 127
    switch $argv[1]
        case cd
            # Implement `brew cd <location>` to quickly move to Homebrew dirs.
            set --erase argv[1] # shift `cd` out of the arguments
            switch $argv[1]
                case cache caskroom cellar prefix repo repository
                    cd (command brew --$argv[1] $argv[2..-1])
                    return
                case '*'
                    printf >&2 "%s: destination unknown\\n" "$destination"
                    return 1
            end
        case --cask
            # Auto-fix `brew --cask <cmd> <args>` to `brew <cmd> --cask <args>`
            set argv $argv[2] $argv[1] $argv[3..-1]
            echo >&2 "Running `brew $argv` instead..."
        case uses
            # Add default behaviour to `brew uses`
            if string match -vq -- '-*' $argv[2]
                set argv $argv[1] --installed $argv[2..-1]
                echo >&2 "Running `brew $argv` instead..."
            end
    end

    command brew $argv
end
