# Disable because reader_write_title() in reader.cpp forces writing to both
# the "window" and "icon" titles. If the terminal emulator makes a distinction
# between them, it's a distinction worth keeping, hence my reimplementation.
function fish_title; end
