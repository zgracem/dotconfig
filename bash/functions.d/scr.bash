scr()
{   # create & change to a temporary directory
	# https://github.com/tejr/dotfiles/blob/master/bash/bashrc.d/scr.bash

	pushd -- "$(mktemp -d)"
}
