#!/usr/bin/env fish

cd $__fish_config_dir

function check-fish-files
    for fish_file in **.fish
        fish --no-execute "$fish_file"
    end
end

check-fish-files
