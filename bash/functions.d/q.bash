q()
{ #: - prints the exit status of a command or [[ … ]] expression
  #: $ q '<expr>'         #=> status of `[[ $expr ]]`
  #: $ <some_command>; q  #=> status of `some_command`

  # We have to capture this immediately, because $? will be overwritten.
  local last_exit=$?

  # Preferences!
  local true_colour=$esc_true
  local false_colour=$esc_false

  # Our functionality is determined by number of arguments:
  case $# in
    0)  # No arguments: Pretty-print the last command's exit status.
        # We already know we want to return true, so we're creating
        # a tautologically true expression to test later.
        local expr="$last_exit -eq 0"
        ;;
    1)  # One argument: Evaluate like [[ (and pretty-print result).
        local expr="$@"
        ;;
    *)  # 2+ arguments: You're doing it wrong.
        fx_usage >&2
        return 64
        ;;
  esac

  # Run the test. Capture standard error to check later.
  answer=$(eval "[[ $expr ]] && echo true" 2>&1)
  local colour=

  case $answer in
    *error*)  # Syntax error from [[
              scold "$FUNCNAME: bad expression"
              return 2
              ;;

    true)     colour=$true_colour
              ;;

    "")       answer="false"
              colour=$false_colour
              if (( $# == 0 && last_exit > 1 )); then
                # This may be interesting information.
                answer+=" ($last_exit)"
              fi
              ;;
  esac

  printf "%b\n" "${colour}${answer}${esc_reset}"

  return $last_exit
}
