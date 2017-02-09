emoji_support()
{ #: - checks TERM_PROGRAM for emoji support
  #: = true/false
  case $TERM_PROGRAM in
    Apple_Terminal|iTerm.app|Prompt_2|Coda)
      return 0 ;;
    *)
      return 1 ;;
  esac
}
