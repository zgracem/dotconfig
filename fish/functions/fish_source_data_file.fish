function fish_source_data_file -d "Evaluate contents of actual or embedded file"
    if fish-is-older-than 4.1
        source "$__fish_data_dir/$argv[1]"
        return
    else if set -q __fish_data_dir[1]
        source "$__fish_data_dir/$argv[1]"
    else
        status get-file $argv[1] | source
    end
end
