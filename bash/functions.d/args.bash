args()
{   # count and display arguments
    # http://mywiki.wooledge.org/WordSplitting

    local num_args="$#"

    printf '%b%d:%b' \
        "$esc_hi" "$num_args" "$esc_reset"

    local arg
    for arg in "$@"; do
        printf ' %b<%b%s%b>%b' \
            "$esc_magenta" "$esc_reset" "$arg" \
            "$esc_magenta" "$esc_reset"
    done
    printf '\n'
}
