if string match -q "Cygwin" $PLATFORM
    set -l package_dir (path resolve (status filename | path dirname)/..)
    set -p fish_function_path $package_dir/functions
    set -p fish_complete_path $package_dir/completions
end
return 101
