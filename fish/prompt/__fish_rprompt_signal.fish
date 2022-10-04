function __fish_rprompt_signal -a code
    test $code -ne 0; or return

    set_color $fish_color_status
    fish_status_to_signal $code

    set_color normal
    echo -n " "
end
