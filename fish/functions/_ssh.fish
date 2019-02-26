function _ssh --wraps ssh --description 'Open an SSH session in a new window'
  set -l cmd "ssh -t $argv"
  set -l title (string split -m1 . $argv[1])[1]

  if in-tmux
    tmux new-window -n $title "$cmd"
  else
    eval "$cmd"
  end
end
