function bind_smart_forward
    set cmd (commandline)
    set cmd_cut (commandline -c)
    if string match -q "$cmd_cut" "$cmd"
        # We are at the end of the commandline.
        commandline -f forward-word
    else
        # Not at the end.
        commandline -f forward-single-char
    end
end