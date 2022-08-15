function __fish_is_nth_arg -a n -d 'Test if current arg is the Nth (regardless if switch or not)'
    set -l tokens (commandline -poc)
    test (count $tokens) -eq "$n"
end
