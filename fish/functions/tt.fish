function tt --description 'Open tmux'
	set -q argv[1]; or set -l argv[1] main
	tmux new-session -A -s $argv[1]
end
