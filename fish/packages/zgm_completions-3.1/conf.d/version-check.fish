if fish-is-older-than 3.1.0
    set -g -p fish_complete_path (realpath (dirname (status filename))/..)/completions
end

exit 101
