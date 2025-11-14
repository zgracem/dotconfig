# Before fish 4.2, the `fish_title` functionality wrote to both the "window"
# and "icon" (or tab) titles with the "OSC 0" escape sequence. I wanted to
# maintain the distinction between them, hence the reimplementations
# in `my-title-window` and `my-title-tab`. fish 4.2+ simply calls out to
# those functions.
if fish-is-newer-than 4.2
    function fish_title; my-title-window; end
else
    function fish_title; end
end
