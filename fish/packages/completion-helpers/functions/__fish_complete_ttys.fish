function __fish_complete_ttys
    ps a -o tty | sed 1d | uniq
end
