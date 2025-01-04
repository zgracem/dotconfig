function __fish_is_nth_arg -a n -d 'Test if current arg is the Nth (regardless if switch or not)'
    set -l token_switch --tokenize
    fish-is-newer-than 4.0b1 # released Dec 2024
    and set token_switch --tokens-expanded
    set -l tokens (commandline --current-process $token_switch --cut-at-cursor)
    test (count $tokens) -eq "$n"
end
