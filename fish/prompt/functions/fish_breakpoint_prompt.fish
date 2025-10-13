# Overrides $__fish_data_dir/functions/fish_breakpoint_prompt.fish
# N.B. `breakpoint` doesn't work in scripts!
# See https://github.com/fish-shell/fish-shell/issues/4823
function fish_breakpoint_prompt --description 'A prompt to be used when `breakpoint` is executed'
    set -l last_exit $status
    set -l glyph ‼

    # -L/--level is an undocumented option to `status`
    set -l function (status --level=2 function)

    ## These still don't work as of fish 3.6.4 :/ -- ZGM 2023-12-07
    #set -l filename (status -L2 filename | path basename)
    #set -l lineno (status -L2 line-number)

    if test -z "$function" -o "$function" = 'Not a function'
        set function main
    end

    if test $last_exit -ne 0
        set_color $fish_color_error
    else
        set_color brcyan
    end
    echo -n $glyph

    set_color --dim
    echo -n " $function() "

    set_color cyan
    echo -n "»"
    set_color normal
    echo -n " "
end
