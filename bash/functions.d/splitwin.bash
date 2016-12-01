splitwin()
{ # open in a new tmux windowpane, if applicable
  # Usage: splitwin COMMAND [ARGS]

  local cmd arg i=0
  local -a args

  if _inTmux; then
    if [[ -z $1 ]]; then
      command tmux split-window -h
    else
      until [[ $# -eq 0 ]]; do
        printf -v args[$i] %q "$1"
        # printf -v arg %q "$1"
        # args[$i]=$arg
        ((i++))
        shift
      done

      command tmux split-window -h "$cmd ${args[*]}"
    fi
  else
    $cmd "$@"
  fi
}
