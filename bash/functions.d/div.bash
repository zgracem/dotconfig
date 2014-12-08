div()
{   # print a bright divider across the terminal

	local p="${1:-=}"

    local line
    printf -v line '%*s' $COLUMNS

    printf "\n${esc_hi}${line// /$p}${esc_reset}\n\n"
}
