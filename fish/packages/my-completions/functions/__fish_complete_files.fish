# Based on $__fish_data_dir/functions/__fish_complete_directories.fish
function __fish_complete_files -a token desc
    if not set -q desc[1]
        set -f desc File
    end

    if not set -q token[1]
        set -f token (commandline --current-token --cut-at-cursor)
    end

    # "Cheat" to complete files by calling `complete -C` on an empty command
    # and filtering out directories.
    set -f files (complete -C"'' $token" | string match -rv '.*/$')

    if set -q files[1]
        printf "%s\n" $files\t"$desc"
    end
end
