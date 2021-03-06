function fix-path --description 'Remove duplicate and missing dirs from a path variable' -a var
    set -l ORIGINAL_PATH $$var
    set -l FIXED_PATH

    for dir in $ORIGINAL_PATH
        if contains -- $dir $FIXED_PATH
            continue
        else if test -d "$dir"
            set FIXED_PATH $FIXED_PATH $dir
        end
    end

    # PATH variables with colons break in fish 3.3
    # https://github.com/fish-shell/fish-shell/issues/8095
    set -gx $var $FIXED_PATH
    return

    # If the original variable name was uppercase, export it back to itself as
    # a single string; fish will separate its elements properly with colons.
    # Otherwise export it as a regular fish list.
    if not string upper -q "$var"
        set -gx $var "$FIXED_PATH"
    else
        set -gx $var $FIXED_PATH
    end
end
