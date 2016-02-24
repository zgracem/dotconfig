q()
{   # exit code tester and wrapper for [[ ... ]]
    # Usage: q '-d /path/to/dir'
    #        q '-n $SSH_TTY'
    #        some_command; q

    local lastExit=$?

    case $# in
        0)
            local expr="$lastExit -eq 0"
            ;;
        1)
            local expr="$@"
            ;;
        *)
            scold "Usage: $FUNCNAME [EXPRESSION]\n'EXPRESSION' uses [[ ... ]] syntax"
            return $EX_USAGE
            ;;
    esac

    # test it
    local result
    result="$(eval "[[ $expr ]] && echo true" 2>&1)"

    case $result in
        *error*)
            # syntax error
            scold "$FUNCNAME" "bad expression"
            return $EX_USAGE
            ;;
        *true*)
            # true
            local qColour="${esc_true}"  # green (set in colours.bash)
            local qAnswer='true'
            ;;
        *)  # false
            local qColour="${esc_false}" # red
            local qAnswer='false'
            ;;
    esac

    printf '%b%b%b\n' $qColour $qAnswer $esc_reset

    return $EX_OK
}
