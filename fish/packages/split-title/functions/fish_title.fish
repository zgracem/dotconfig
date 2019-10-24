# Disable because reader_write_title() in reader.cpp forces writing to both
# the "window" and "icon" titles. If the terminal emulator makes a distinction
# between them, it's a distinction worth keeping, hence my reimplementation.
function fish_title; end
# See also: ~/.config/fish/conf.d/__fish_prompt_update_title.fish
#           ~/.config/fish/functions/fish_tab_title.fish
#           ~/.config/fish/functions/fish_window_title.fish
