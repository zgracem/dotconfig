args()
{   # count and display arguments
    # http://mywiki.wooledge.org/WordSplitting

    printf '%b%d%b:' \
        "$esc_hi" "$#" "$esc_reset"

    local arg
    for arg in "$@"; do
        printf ' %b%b%b' \
            "${esc_brmagenta}<${esc_reset}" \
            "${esc_italic}${arg}${esc_reset}" \
            "${esc_brmagenta}>${esc_reset}"
    done
    printf '\n'
}
