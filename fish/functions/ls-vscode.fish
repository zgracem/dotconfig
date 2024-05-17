function ls-vscode -d "List all Visual Studio Code workspaces"
    set -f dir ~/Library/"Application Support"/Code/User/workspaceStorage
    path is -d $dir; or return 1

    for folder in $dir/*/
        set json_file (path resolve $folder/workspace.json)
        set -f url (jq -r '.folder' $json_file)
        if string match -q null $url
            set -f path (jq -r '.configuration.path' $json_file)
            if string match -q null $path
                set -f ws (jq -r '.workspace' $json_file)
                if string match -q null $ws
                    echo -s (set_color brred) "No .folder, .path, or .workspace: " \
                        (set_color red) (basename $folder) (set_color normal)
                else
                    set -f wsfile (string match -rg '^file://(/.+)' $ws | string unescape --style=url)
                    if path is $wsfile
                        echo -s (set_color brgreen) "Found .workspace: " (set_color green) $wsfile \
                            ": " (set_color normal) (basename $folder)
                        continue
                    else
                        echo -s (set_color brred) ".workspace not found: " \
                            (set_color red) $wsfile ": " \
                            (set_color normal) (basename $folder)
                        # break
                    end
                end
            else
                if path is $path
                    echo -s (set_color brgreen) "Found .path: " (set_color green) $path \
                        ": " (set_color normal) (basename $folder)
                    continue
                else
                    echo -s (set_color brred) ".path not found: " \
                        (set_color red) $path ": " \
                        (set_color normal) (basename $folder)
                    # break
                end
            end
        else
            set -f file (string match -rg '^file://(/.+)' $url | string unescape --style=url)
            if path is $file
                echo -s (set_color brgreen) "Found .file: " (set_color green) $file \
                    ": " (set_color normal) (basename $folder)
                continue
            else
                echo -s (set_color brred) ".folder not found: " \
                    (set_color red) $file ": " \
                    (set_color normal) (basename $folder)
                # break
            end
        end
    end
end
