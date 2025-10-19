set -q fish_package_path[1]
or set -g fish_package_path

for dir in $__fish_config_dir/packages/*/
    set -a fish_package_path (string trim --right --chars=/ $dir)
end

# remove duplicate & nonexistent directories
set fish_package_path (path filter -d $fish_package_path | un1q)

for package_dir in $fish_package_path
    set -l bootstrapped 0

    if path is -d $package_dir
        if path is -d $package_dir/conf.d
            for file in $package_dir/conf.d/*.fish
                source $file
                # If anything in conf.d/*.fish exits 101, the package is
                # is assumed to have "bootstrapped" itself, and auto-loading
                # immediately stops. No functions or completions will be added.
                if test $status -eq 101
                    set bootstrapped 1
                    break
                end
            end
        end

        if test $bootstrapped -eq 1
            continue
        end

        set -p fish_function_path $package_dir/functions
        set -p fish_complete_path $package_dir/completions

        if path is -f $package_dir/init.fish
            source $package_dir/init.fish
        end
    end
end
