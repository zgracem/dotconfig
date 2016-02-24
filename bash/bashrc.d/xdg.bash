export XDG_DATA_HOME="$HOME/share"
export XDG_CONFIG_HOME="$dir_config"

case $OSTYPE in
	darwin*)
		export XDG_CACHE_HOME="$HOME/var/cache"
		;;
	cygwin)
		export XDG_CACHE_HOME='/var/cache'
		;;
	*)
		export XDG_CACHE_HOME="$HOME/var/cache"
		;;
esac
