function archive-acorn-layers
    argparse c/clear f/force n/dry-run q/quiet s/silent v/verbose -- $argv
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

    function has-xattr-timestamp
        xattr -p $attr $argv[1] >/dev/null 2>&1
    end

    if set -q _flag_clear
        for acorn_file in $argv
            if not has-xattr-timestamp $acorn_file
                set -q _flag_silent
                or echo >&2 "*** No timestamp to clear:" (short_home $acorn_file)
                continue
            end

            if set -q _flag_dry_run
                echo "~~~ Would clear timestamp on" (short_home $acorn_file)
            else
                xattr -d $attr $acorn_file
                or return

                set -q _flag_verbose
                and echo "::: Cleared timestamp on" (short_home $acorn_file)
            end
        end
        return
    end

    function add-xattr-timestamp
        xattr -w $attr (date +%s) $argv[1]
        or return
        if set -q _flag_verbose
            echo -n "### Added timestamp to" (short_home $argv[1]):
            xattr -p $attr $argv[1]
        end
        true
    end

    for acorn_file in $argv
        if has-xattr-timestamp $acorn_file
            set -q _flag_quiet; or echo >&2 "+++ Already processed:" (short_home $acorn_file)
            set -q _flag_force; or continue
        end

        if test (count $argv) -gt 1; and not set -q _flag_silent
            echo "... Processing:" $acorn_file
        end

        set -l layers (list-acorn-layers $acorn_file)

        if test -z "$layers"
            set -q _flag_quiet; or echo >&2 "*** No archivable layers:" (basename $acorn_file)
            if set -q _flag_dry_run
                echo "~~~ Would timestamp" (short_home $acorn_file): (date +%s)
            else
                add-xattr-timestamp $acorn_file
            end
            continue
        end

        set -l unique_layers (string replace -r '^Copy of ' '' $layers | path change-extension "" | un1q)
        for layer in $unique_layers
            switch $layer
                case "IMG*"
                    set -f used_dir $used_art_dir
                    set -f layer_files (path filter $inboxes/$layer.{jpg,JPG,jpeg,png,PNG})
                case "*-unsplash"
                    set -f used_dir $used_stock_dir
                    set -l layer_dirs $stock_dirs/**/
                    set -f layer_files (path normalize $layer_dirs/$layer.jpg | path filter)
                case "*"
                    continue
            end # switch $layer

            set -f --erase found
            for layer_file in (unique $layer_files)
                if set -fq found[1]
                    echo "!!! Found already: $found"
                    continue
                else if set -f found (path filter $layer_file)
                    echo "!!! Found: $found"
                    if set -lq _flag_dry_run
                        echo "~~~ Would archive:" (short_home $layer_file)
                    else
                        /bin/mv $layer_file $used_dir; or return
                        set -q _flag_silent
                        or echo ">>> Archived:" (short_home $layer_file)
                    end
                    continue
                else if set -f found (path filter $used_dir/$layer.*)
                    echo "!!! Found: $found"
                    set -q _flag_quiet
                    or echo -- "--- Already archived:" (basename $layer_file)
                    continue
                else
                    echo >&2 "*** Missing file: "$used_dir/$layer.jpg
                    set -f --erase found
                end
            end # for layer_file in (unique $layer_files)

            if not set -fq found[1]; and not set -q _flag_quiet
                echo >&2 "*** File not found for layer: $layer"
            end
        end # for layer in $unique_layers

        if set -q _flag_dry_run
            echo "~~~ Would timestamp" (short_home $acorn_file): (date +%s)
        else
            add-xattr-timestamp $acorn_file
        end
    end
end
