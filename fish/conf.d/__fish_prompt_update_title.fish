function __fish_prompt_update_title --on-event fish_prompt
  if functions -q fish_title
    set_terminal_title --window (fish_title)
  end
end
