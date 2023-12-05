# Disable because the default `fish_title` forces writing to both the "window"
# and "icon" (or tab) titles with the "\e]0;" escape sequence. If the terminal
# emulator makes a distinction between them, it's a distinction worth keeping,
# hence my reimplementation.
function fish_title; end
