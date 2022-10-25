function archive-acorn-layers
    argparse f/force n/dry-run q/quiet s/silent v/verbose -- $argv
    or return

    set -q _flag_silent; and set -l _flag_quiet 1
    set -q _flag_silent; or set -q _flag_quiet; and set -e _flag_verbose

    set -l inboxes ~/Library/"Mobile Documents"/com~apple~CloudDocs/Images/_inbox
    # set -a inboxes /Volumes/Hub/Art/inbox.old
    set -l used_art_dir /Volumes/Hub/Art/used

    set -l stock_dirs $HOME/{Downloads,Pictures}/unsplash
    set -l used_stock_dir /Volumes/Hub/Art/used/unsplash

    function list-acorn-layers -a file
        strings -a -n 14 $file | ag --nocolor -o '(?<=public\.tiff).+(?=MM$)'
    end

    set -fx attr org.inescapable.archive-acorn-layers.archived

    function add-xattr-timestamp
        xattr -w $attr (date +%s) $argv
        or return
        and set -q _flag_verbose; and xattr -v -p $attr $argv
    end

    for acorn_file in $argv
        xattr -p $attr $acorn_file >/dev/null 2>&1
        and not set -q _flag_force; and continue

        if test (count $argv) -gt 1; and not set -q _flag_silent
            echo "### Processing:" $acorn_file
        end

        set -l layers (list-acorn-layers $acorn_file)

        if test -z "$layers"
            set -q _flag_quiet; or echo >&2 "*** No archivable layers:" (basename $acorn_file)
            add-xattr-timestamp $acorn_file
            continue
        end

        for layer in (string replace -r '^Copy of ' '' $layers | un1q)
            switch $layer
                case "IMG*"
                    set -f used_dir $used_art_dir
                    set -f layer_files $inboxes/$layer.{jpg,JPG,jpeg}
                case "*-unsplash"
                    set -f used_dir $used_stock_dir
                    set -l layer_dirs $stock_dirs/**/
                    set -f layer_files (path normalize $layer_dirs/$layer.jpg)
                case "*"
                    continue
            end

            set -f --erase found
            for layer_file in (unique $layer_files)
                if set -fq found[1]
                    continue
                else if path is -f $layer_file
                    set -f found $layer_file
                    if set -lq _flag_dry_run
                        echo "~~~ Would archive:" (short_home $layer_file)
                    else
                        /bin/mv $layer_file $used_dir
                        and not set -q _flag_silent
                        and echo ">>> Archived:" (short_home $layer_file)
                    end
                    continue
                else if path is -f $used_dir/$layer.jpg
                    set -f found $used_dir/$layer.jpg
                    set -q _flag_quiet
                    or echo -- "--- Already archived:" (basename $layer_file)
                    continue
                end
            end

            if not set -fq found[1]; and not set -q _flag_quiet
                echo >&2 "*** File not found for layer: $layer"
            end
        end

        if not set -q _flag_dry_run
            add-xattr-timestamp $acorn_file
        end
    end
end
