emoji_support()
{ #: - checks TERM_PROGRAM for emoji support
  #: = true/false
  [[ $TERM_PROGRAM =~ Apple_Terminal|iTerm\.app|Prompt_2|Coda ]]
}
