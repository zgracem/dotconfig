function man --description 'Display manual pages in a new window with a nice title'
  # Let man pipe to other things.
  if not isatty stdout
    command man $argv
    return
  end

  # Some switches don't open a man page. Let those do their thing.
  if test (string sub --length 1 -- $argv[1]) = "-"
    switch (string sub --start 2 -- $argv[1])
    case '*d*' '*f*' '*h*' '*k*' '*V*' '*w*' '*W*' '*?*'
      command man $argv
      return
    case '*'
      true
    end
  end

  # Get a nice title for the window.
  set -l title (_man_title $argv); or return

  if in-tmux
    tmux new-window -n $title "env MANLESS= man $argv"
  else
    set_terminal_title --both $title
    command man $argv
  end
end
