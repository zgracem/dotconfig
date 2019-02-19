function emoji_support --description 'Returns true if TERM_PROGRAM supports emoji'
  switch "$TERM_PROGRAM"
  case Apple_Terminal 'iTerm*' Prompt_2 Coda
    true
  case '*'
    false
  end
end
