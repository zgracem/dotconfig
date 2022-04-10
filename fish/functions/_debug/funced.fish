# Overrides $__fish_data_dir/functions/funced.fish
# because the way `funced` currently works can result in data loss.
#
# Specifically, it uses the `functions` builtin to print the interpreted source
# code of the function, which preserves only some comments, and ignores (and
# therefore destroys) everything outside the main function definition.
# I'm reluctant to call this a bug in fish but it's definitely not behaviour
# I want, so here's a minimal reimplementation that behaves the way I prefer
# (i.e. it only uses `functions` when there's no existing function file.)
function funced --wraps funcsave --description 'Edit a function interactively' -a function
    set -l function_info (functions --details --verbose -- $function)
    set -l function_source $function_info[1]
    set -l function_line $function_info[3]

    switch $function_source
        case n/a - stdin
            set function_source "$__fish_config_dir/functions/$function.fish"
    end

    if not test -f $function_source
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

    if test -f $function_source
        source $function_source
    else
        echo >&2 "file not found: $function_source"
        return 1
    end
end
