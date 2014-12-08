# -----------------------------------------------------------------------------
# ~zozo/.config/bash/profile
# executed by bash(1) for login shells
# -----------------------------------------------------------------------------

# abort if bash < v2.0
if ! test "$BASH_VERSINFO"; then
    return
fi

function debug_echo {
	if test	":$z_debug:" = ":true:"; then
		echo "$@"
	else
		return 0
	fi
}

# source .profile
if [[ -r $HOME/.config/sh/profile.sh ]] ; then
	debug_echo "# sourcing $HOME/.config/sh/profile.sh..."
    . "$HOME/.config/sh/profile.sh"
fi

# source .bashrc
if [[ -r $HOME/.config/bash/bashrc.bash ]]; then
	debug_echo "# sourcing $HOME/.config/bash/bashrc.bash..."
    . "$HOME/.config/bash/bashrc.bash"
fi
