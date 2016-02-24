ct()
{   # check terminals

    local fd output

    for fd in {0..2}; do
        if [[ -t $fd ]]; then
            output+=$esc_true
        else
            output+=$esc_false
        fi
        
        output+="${fd}${esc_reset} "
    done

    printf '%b\n' "${output}" # | tee /dev/tty
}
