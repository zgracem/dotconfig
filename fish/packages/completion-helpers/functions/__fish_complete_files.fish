function __fish_complete_files -a token
    # "Cheat" to complete files by calling `complete -C` on a fake command name,
    # like `__fish_complete_directories` does.
    set -l fake_command aaabccccdeeeeefffffffffgghhhhhhiiiii
    complete -C"$fake_command $token"
end
