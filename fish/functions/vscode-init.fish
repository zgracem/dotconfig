function vscode-init --description 'Initialize directory for use with VS Code'
    set -l dir $PWD/.vscode
    set -l skel $HOME/etc/vscode-workspace-skel
    set -q argv[1]; and set dir $argv[1]/.vscode

    mkdir -p "$dir"

    if not path is -f $dir/settings.json
        echo '{}' >"$dir/settings.json"
    end

    if not path is -f $dir/extensions.json
        jq --null-input '.recommendations=[]' >"$dir/extensions.json"
    end

    if not path is -f $dir/tasks.json; and path is -d $skel
        cp -a $skel/tasks.json $dir/tasks.json
    end
end
