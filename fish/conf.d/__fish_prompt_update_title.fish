function __fish_prompt_update_title --on-event fish_prompt
  if functions -q fish_window_title fish_tab_title
    set_terminal_title --window (fish_window_title)
    set_terminal_title --tab (fish_tab_title)
  end
end
