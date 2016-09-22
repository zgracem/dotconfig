# -----------------------------------------------------------------------------
# final initialization script
# sourced at the end of ~/.bashrc
# -----------------------------------------------------------------------------

# add config file symlinks if necessary (see bashrc.d/config.bash)

if [[ ! -e ~/.npmrc ]] && _inPath npm; then
  _z_config_symlink npmrc
fi

if [[ ! -e ~/.irbrc ]] && _inPath irb; then
  _z_config_symlink ruby/irbrc
fi

if [[ ! -e ~/.vimrc ]] && _inPath vim; then
  _z_config_symlink vimrc
fi

if [[ ! -e ~/.wgetrc ]] && _inPath wget; then
  _z_config_symlink wget/wgetrc
fi

# -----------------------------------------------------------------------------

# cute login banner
if [[ -x $dir_scripts/loginbanner.sh ]]; then
    "${dir_scripts}/loginbanner.sh"
fi

# this day in history...
if [[ -x $dir_scripts/util/matins.sh ]]; then
    "${dir_scripts}/util/matins.sh"
fi

# countdown (date & function set in private.d/countdown.bash)
_isFunction liz && liz

# print bash version if not the latest release (variables set in bashrc.bash)
if (( this_bash < latest_bash )) \
  || [[ ${BASH_VERSINFO[4]} != "release" ]]\
  || [[ $BASH != $SHELL ]]; then
  printf 'GNU bash, version %s (%s)\n' "$BASH_VERSION" "$MACHTYPE"
fi
