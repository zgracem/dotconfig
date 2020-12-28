function print_fish_colors --description 'Shows the various fish colors being used'
    # Based on <https://github.com/fish-shell/fish-shell/issues/3443#issuecomment-253838672>
    set -l width 38
    set -l padded (math $width + 2)
    set -l bar (string repeat -N -n$padded ─)

    set -l clear (set_color normal)
    set -l bold (set_color --bold)
    set -l err (set_color --bold white --background=red)

    set -l color_vars (set -n | string match -are '^fish_(?:\S+_)?color_')
    test -n "$color_vars"; or return 1

    echo "┌$bar┬$bar┐"
    printf "│ %-"$width"s │ %-"$width"s │\n" Variable Definition
    echo "├$bar┼$bar┤"

    for var in $color_vars
        set -l def $$var
        set -l esc (set_color $def 2>/dev/null)
        or begin
            # invalid colour definition!
            printf "│ %-"$width"s │ %s%-"$width"s$clear │\n" "$var" $err "$def"
            continue
        end
        printf "│ $esc%-"$width"s$clear │ %-"$width"s$clear │\n" "$var" "$def"
    end

    echo "└$bar┴$bar┘"
end
