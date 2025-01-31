function ls-vscode -d "List all Visual Studio Code workspaces"
    set -f dir ~/Library/"Application Support"/Code/User/workspaceStorage
    path is -d $dir; or return 1

    for folder in $dir/*/
        set -f json_file (path resolve $folder/workspace.json)
        path is -f $json_file; or continue

        set -f hash (path basename $folder)

        set -f url (jq -r '.folder' $json_file)
        if string match -q null $url
            set -f path (jq -r '.configuration.path' $json_file)
            if string match -q null $path
                set -f ws (jq -r '.workspace' $json_file)
                if string match -q null $ws
                    echo -s (set_color brred) "No .folder, .path, or .workspace: " \
                        (set_color red) $hash (set_color normal)
                else
                    set -f wsfile (string match -rg '^file://(/.+)' $ws | string unescape --style=url)
                    if path is $wsfile
                        echo -s (set_color brgreen) ".workspace: " (set_color green) $wsfile \
                            ": " (set_color normal) $hash
                    else
                        echo -s (set_color brred) "no .workspace: " \
                            (set_color red) $wsfile ": " \
                            (set_color normal) $hash
                    end
                end
            else
                if path is $path
                    echo -s (set_color brgreen) ".path: " (set_color green) $path \
                        ": " (set_color normal) $hash
                else
                    echo -s (set_color brred) "no .path: " \
                        (set_color red) $path ": " \
                        (set_color normal) $hash
                end
            end
        else
            set -f file (string match -rg '^(?:\w+)://(/.+)' $url | string unescape --style=url)
            if string match -q "*vscode-remote://*" $url
                echo -s (set_color bryellow) ".folder: " (set_color yellow) (string unescape --style=url $url) \
                    ": " (set_color normal) $hash
            else if path is $file
                echo -s (set_color brgreen) ".folder: " (set_color green) $file \
                    ": " (set_color normal) $hash
            else
                echo -s (set_color brred) "no .folder: " \
                    (set_color red) $file ": " \
                    (set_color normal) $hash
            end
        end
    end
end
