function my-prompt-right-status -a code
    test $code -ne 0; or return

    if test $code -eq 141 # SIGPIPE is not always an error
        set_color bryellow
    else
        set_color $fish_color_status
    end

    fish_status_to_signal $code

    set_color normal
    echo -n " "
end
