set -q fish_package_path[1]
or set -g fish_package_path

for dir in $__fish_config_dir/packages/*/
  set -a fish_package_path (string trim --right --chars=/ $dir)
end

function __package_init --on-variable fish_package_path
  __fish_fix_path fish_package_path

  for dir in $fish_package_path
    if test -d "$dir"
      if test -d "$dir/conf.d"
        for file in $dir/conf.d/*.fish; source "$file"; end
      end

      set -p fish_function_path $dir/functions
      set -p fish_complete_path $dir/completions

      if test -f "$dir/init.fish"
        source "$dir/init.fish"
      end
    end
  end
end

__package_init
