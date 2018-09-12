newwin()
{ #: - runs COMMAND, opening a new tmux/GNU screen window, if applicable
  #: $ newwin [-t|--title <title>] [<command>] [<args>]
  #: | -t/--title = title of new window (default: <command>)

  local title_regex='^-?-t(itle)?$'
  local title cmd arg i=0
  local -a args

  if [[ -z $1 ]]; then
    if _inTmux; then
      command tmux new-window
    elif _inScreen; then
      command screen
    fi
    return
  fi

  if [[ $1 =~ $title_regex ]]; then
    title="$2"
    shift 2
  else
    title="${1##*/}"
    printf -v cmd %q "$1"
    shift
  fi

  if _inTmux; then
    until [[ $# -eq 0 ]]; do
      printf -v args[$i] %q "$1"
      ### for bash > 4.1:
      # printf -v arg %q "$1"
      # args[$i]=$arg
      ((i++))
      shift
    done

    command tmux new-window -n "$title" "$cmd ${args[*]}"
  elif _inScreen; then
    # shellcheck disable=SC2086
    command screen -t "$title" $cmd "$@"
  else
    $cmd "$@"
  fi
}
