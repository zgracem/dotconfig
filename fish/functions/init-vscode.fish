function init-vscode --description 'Initialize directory for use with VS Code'
    set -l dir $PWD/.vscode
    set -l skel $HOME/Developer/skel/vscode
    set -q argv[1]; and set dir $argv[1]/.vscode

    mkdir -pv "$dir"

    if not path is -f $dir/settings.json
        echo '{}' >"$dir/settings.json"
    end

    if not path is -f $dir/extensions.json
        jq --null-input '.recommendations=[]' >"$dir/extensions.json"
    end

    if not path is -f $dir/tasks.json; and path is -d $skel
        cp -aiv $skel/tasks.json $dir/tasks.json
    end
end
