# Overrides $__fish_data_dir/functions/funced.fish
# because the way `funced` previously worked could result in data loss.
# (See fish-shell/issues/391 and fish-shell/pull/8130.)
#
# Fixed in fish-shell@8dd4c67 -- but I prefer my implementation. ¯\_(ツ)_/¯
function funced --wraps funcsave --description 'Edit a function interactively' -a function
    set -l function_info (functions --details --verbose -- $function)
    set -l function_source $function_info[1]
    set -l function_line $function_info[3]

    switch $function_source
        case n/a - stdin
            set function_source "$__fish_config_dir/functions/$function.fish"
    end

    if not path is -f $function_source
        set -l foursp "    "
        if functions -q $function
            functions -- $function | string replace \t "$foursp" >$function_source
        else
            echo -e "function $function --description ''\\n$foursp\\nend" >$function_source
        end
    end

    if test $function_line -gt 1
        if string match -rq "\bcode\b" "$VISUAL"
            $VISUAL --goto $function_source:$function_line
        else if string match -rq '\b[ng]?vim$' "$VISUAL"
            $VISUAL +$function_line $function_source
        else
            $VISUAL $function_source:$function_line
        end
    else
        $VISUAL $function_source
    end

    if path is -f $function_source
        source $function_source
    else
        echo >&2 "file not found: $function_source"
        return 1
    end
end
