zd()
{   # toggle dotfile debugging variable

	if [[ -z $_zd_ ]]; then
		export _zd_=true
	else
		unset -v _zd_
	fi

	printf '_zd_='
	q '-n $_zd_'
}
