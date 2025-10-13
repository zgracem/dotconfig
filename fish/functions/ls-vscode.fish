function ls-vscode -d "List all Visual Studio Code workspaces"
    argparse s/src -- $argv
    or return

    set -f dir ~/Library/"Application Support"/Code/User/workspaceStorage
    path is -d $dir; or return 1

    if set -q argv[1]
        set -f files $dir/$argv/workspace.json
    else
        set -f files $dir/*/workspace.json
    end

    for file in $files
        set -l hash (path basename (path dirname $file))
        echo -ns $hash \t

        if set -q _flag_src
            echo -ns (jq -r 'if has("configuration") then ".path" elif has("folder") then ".folder" elif has("workspace") then ".ws" else ".ERROR" end' $file) \t
        end

        set -l data (jq -r '.configuration.path // .folder // .workspace // "¡ERROR!"' $file)

        switch $data
            case "/*"
                set -f path $data
            case "file://*"
                set -f path (string unescape --style=url $data | string replace -r "^file://" "")
            case "vscode-remote://*"
                set -f path (string unescape --style=url $data)
                echo -s (set_color bryellow) 302 (set_color yellow) \t $path (set_color normal)
                continue
            case "*"
                echo -s (set_color brred) 500 (set_color red) \t $data (set_color normal)
                continue
        end
        if path is $path
            echo -s (set_color brgreen) 200 (set_color green) \t (prompt_pwd -Z $path) (set_color normal)
        else
            echo -s (set_color brred) 404 (set_color red) \t \e"[9m" (prompt_pwd -Z $path) (set_color normal)
        end
    end
end
