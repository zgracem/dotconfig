function fish_subtract_path --description "Remove an entry from PATH/fish_user_paths"
    argparse P/path u/user-path v/verbose -- $argv
    or return

    if not set -q _flag_path; and not set -q _flag_user_path
        set -f _flag_path true
        set -f _flag_user_path true
    end

    set -f matched false
    set -f NEWPATH
    set -f --path new_fish_user_paths

    for unwanted_dir in $argv
        if contains $unwanted_dir $PATH; and set -q _flag_path
            set -f matched true
            for path_dir in $PATH
                if string match -vq $unwanted_dir $path_dir
                    set -a NEWPATH $path_dir
                else if set -q _flag_verbose
                    echo "Removed $path_dir from \$PATH"
                end
            end
            set -gx PATH $NEWPATH
        end

        if contains $unwanted_dir $fish_user_paths; and set -q _flag_user_path
            set -f matched true
            for user_path_dir in $fish_user_paths
                if string match -vq $unwanted_dir $user_path_dir
                    set -a new_fish_user_paths $user_path_dir
                else if set -q _flag_verbose
                    echo "Removed $user_path_dir from \$fish_user_paths"
                end
            end
            set -gx fish_user_paths $new_fish_user_paths
        end
    end

    string match -q true $matched
end
