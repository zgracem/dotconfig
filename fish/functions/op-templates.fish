function op-templates -d "Write all 1Password templates to disk"
    set -x OP_FORMAT json

    set -l types (op item template list | jq -r 'sort_by(.uuid) | .[].name')
    or return

    set -l dir ~/Dropbox/share/op/templates
    mkdir -p $dir

    for type in $types
        set -l file (string lower $type | tr " " -).json
        op item template get $type >$dir/$file
        or break

        echo $dir/$file
    end
end
