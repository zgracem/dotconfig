function ctty -d "Check the status of TTYs"
    for fd in stdout stdin stderr
        if isatty $fd
            set_color green
        else
            set_color red
        end
        echo -ns $fd (set_color normal) " "
    end
    echo
end
