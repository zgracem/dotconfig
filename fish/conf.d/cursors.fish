# Source: https://fishshell.com/docs/current/interactive.html#vi-mode-commands
# Emulates vim's cursor shape behavior
! set -q fish_cursor_default; and return

# Make the normal mode cursor a block
set -U fish_cursor_default block
# Make the insert mode cursor a line
set -U fish_cursor_insert line
# Make the replace mode cursor an underscore
set -U fish_cursor_replace_one underscore
# Make the visual mode cursor a block too (redundant due to fish_cursor_default)
set -U fish_cursor_visual block
