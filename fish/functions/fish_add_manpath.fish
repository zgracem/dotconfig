function fish_add_manpath --description "Add paths to the MANPATH"
    # See $__fish_data_dir/functions/fish_add_path.fish
    argparse -x g,U -x a,p g/global U/universal p/prepend a/append v/verbose -- $argv
    or return

    set -l scope $_flag_global $_flag_universal
    set -q scope[1]; or set scope -g

    set -l var MANPATH

    set -l mode $_flag_prepend $_flag_append
    set -q mode[1]; or set mode -p

    for path in $argv
        set -l path (builtin realpath -s -- $path 2>/dev/null)
        # Skip non-existing paths
        path is -d $path; or continue
        # Skip pre-set paths
        contains -- $path $$var; and continue

        set $scope $mode $var $path
        set -q _flag_verbose; and echo "set $scope $mode $var $path"
    end
end
