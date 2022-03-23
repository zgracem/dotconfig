function __flannel_complete_cmds
    set -l func_file (dirname (status filename))/../functions/flannel.fish
    string replace -f -r '^\s+case (\S+)\s+# (.+)$' '$1'\t'$2' <$func_file
end

function __flannel_complete_from_drawer
    set -l files $FLANNEL_DRAWER/*.yaml
    for file in $files
        echo -n (basename $file .yaml)\t\n
    end
end

complete -c flannel -s n -l dry-run
complete -c flannel -n "__fish_is_nth_token 1" -x -a "(__flannel_complete_cmds)"
# complete -c flannel -n "__fish_seen_subcommand_from dump export" -x -a "(__fish_defaults_domains)"
# complete -c flannel -n "__fish_seen_subcommand_from dump export" -o app -a "(__flannel_complete_apps)"
complete -c flannel -n "__fish_seen_subcommand_from import touch" -x -a "(__flannel_complete_from_drawer)"
complete -c flannel -n "__fish_seen_subcommand_from print" -r -F
