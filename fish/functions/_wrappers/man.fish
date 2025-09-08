# Overrides $__fish_data_dir/functions/man.fish
function man --description 'Display manual pages' # in a new window with colours and a nice title
    # Let man pipe to other things.
    if not isatty stdout
        command man $argv
        return
    end

    # Some switches don't open a man page. Let those do their thing.
    set -l switches d f h k V w W "?"
    set -l pattern '['(string join '' $switches)']'
    for arg in $argv[1..-2]
        if string match -q -- "-*" "$arg"
            if string match -rq -- $pattern $arg
                command man $argv
                return
            else
                true
            end
        end
    end

    # Get a nice title for the window.
    set -f manfile (command man -w $argv)
    or return # if the man page doesn't exist

    set -f title (path basename $manfile | string replace -rf '\.([^.]+)(?:\.gz)?$' '($1)')
    or set -f title "man $argv"

    if in-tmux
        tmux new-window -n $title "env MANLESS= man $argv"
    else
        set_terminal_title --both $title
        command man $argv
    end
end
