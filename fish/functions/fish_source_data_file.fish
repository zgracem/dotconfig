function fish_source_data_file -d "Evaluate contents of actual or embedded file"
    if set -q __fish_data_dir[1]
        source "$__fish_data_dir/$argv[1]"
    else
        status get-file $argv[1] | source
    end
end
