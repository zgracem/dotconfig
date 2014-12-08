# reattach a session; detach/create it first if necessary
alias ss='screen -d -R '

# Solarized Light colour scheme
if [[ $solarized == light ]]; then
    SCREENRC="${dir_config}/screenrc.light"
else
	SCREENRC="${dir_config}/screenrc"
fi

export SCREENRC
