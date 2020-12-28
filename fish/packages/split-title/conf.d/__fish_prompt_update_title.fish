function __fish_prompt_update_title --on-event fish_prompt
    functions -q fish_window_title; and set_terminal_title --window (fish_window_title)
    functions -q fish_tab_title; and set_terminal_title --tab (fish_tab_title)
end
