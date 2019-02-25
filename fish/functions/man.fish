function man --description 'Display manual pages in a new window with a nice title'
  if not isatty stdout
    command man $argv
    return
  end

  if [ (string sub -l 1 -- $argv[1]) = "-" ]
    switch (string sub -s 2 -- $argv[1])
    case '*d*' '*f*' '*h*' '*k*' '*V*' '*w*' '*W*' '*?*'
      command man $argv
      return $status
    case '*'
      true
    end
  end

  set -l title (__man_title $argv)
  or return $status

  if in-tmux
    tmux new-window -n $title "env MANLESS= man $argv"
  else
    __fish_prompt_set_window_title $title
    command man $argv
  end
end

function __man_title
  set -l manfile (command man -w $argv)
  or return $status

  set -l match (string match -r '.*/(.+?)\.(.+?)(?:\.gz)?' "$manfile")
  or return $status

  set -l title $match[2]
  set -l section $match[3]

  echo "$title($section)"
end
