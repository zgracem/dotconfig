function get_color256
    set -l CSI \e\[
    set -l sgr_params (set_color $argv | string split $CSI \
        | string match -rg '(\d+)m')
    or return

    set -l params_out
    for pm in $sgr_params
        switch $pm
            case 1 2 3 4 7
                set -a params_out $pm
            case "3*" "4*"
                set -a params_out (string replace -r '^(3|4)(\d)' '${1}8'\n'5'\n'${2}' $pm)
            case "9*" "10*"
                set -l x (string split -m1 -f1 -r "" $pm)
                set -l y (math "$x - 6")
                set -l m (string sub -s-1 "$pm")
                set -l n (math "$m + 8")
                set -a params_out $y"8" "5" $n
        end
    end

    string join ";" $params_out
end

# set -x TERM xterm-256color
# get_color256 red
# get_color256 brred
# get_color256 --background=yellow
# get_color256 --background=brcyan
# get_color256 --bold --italics blue
