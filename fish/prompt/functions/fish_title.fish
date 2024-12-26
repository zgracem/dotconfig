# Disable because the default `fish_title` forces writing to both the "window"
# and "icon" (or tab) titles with the "\e]0;" escape sequence. If the terminal
# emulator makes a distinction between them, it's a distinction worth keeping,
# hence the reimplementations in `fish_title_window` and `fish_title_tab`.
function fish_title; end
