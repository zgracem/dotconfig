# Disable because reader_write_title() in reader.cpp forces writing to both the
# "window" and "icon" (or tab) titles with the "\x1B]0;" escape sequence. If the
# terminal emulator makes a distinction between them, it's a distinction worth
# keeping, hence my reimplementation in ../packages/split-title.
function fish_title; end
