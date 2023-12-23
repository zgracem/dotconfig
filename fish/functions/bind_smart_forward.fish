function bind_smart_forward
    set -l cmd (commandline) # the entire commandline
    set -l cmd_cut (commandline -c) # only the part before the cursor
    if string match -q "$cmd_cut" "$cmd"
        # We are at the end of the commandline.
        commandline -f forward-word
    else
        # Not at the end.
        commandline -f forward-single-char
    end
end
