function my-prompt-right-status -a code
    test $code -ne 0; or return

    if test $code -eq 141
        # SIGPIPE is not always an error
        set -f color bryellow
    else
        set -f color $fish_color_status
    end

    echo -ns (set_color $color) (my-status-to-signal $code) (set_color normal) " "
end
