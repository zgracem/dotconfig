function __fish_prompt_update_title --on-event fish_prompt
    functions -q fish_title_window; and set_terminal_title --window (fish_title_window)
    functions -q fish_title_tab; and set_terminal_title --tab (fish_title_tab)
end
