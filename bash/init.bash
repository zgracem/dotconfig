# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

# add config file symlinks if necessary (see bashrc.d/config.bash)

if [[ ! -e ~/.npmrc ]] && _inPath npm; then
  z::config::symlink npmrc
fi

if [[ ! -e ~/.irbrc ]] && _inPath irb; then
  z::config::symlink ruby/irbrc
fi

if [[ ! -e ~/.vimrc ]] && _inPath vim; then
  z::config::symlink vimrc
fi

if [[ ! -e ~/.wgetrc ]] && _inPath wget; then
  z::config::symlink wgetrc
fi

# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "${dir_scripts}/loginbanner.sh"
fi

# this day in history...
if [[ -x $dir_scripts/matins.sh ]]; then
    "${dir_scripts}/matins.sh"
fi

# countdown (date & function set in private.d/countdown.bash)
_isFunction liz && liz

# print bash version if not the latest release (variables set in bashrc.bash)
if (( this_bash < latest_bash )) || [[ ${BASH_VERSINFO[4]} != "release" ]]; then
  printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"
fi

unset -v latest_bash this_bash
