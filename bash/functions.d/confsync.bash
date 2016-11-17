hconfsync()
{
  local dest="Hiroko:/Users/zozo"

  syncdir "$dir_dropbox/.config" "$dest/.config"
  syncdir "$dir_dropbox/etc"     "$dest/etc" --max-delete=1 --exclude='*.sublime-*'
  syncdir "$dir_dropbox/lib"     "$dest/lib" --max-delete=1
  syncdir "$dir_dropbox/scripts" "$dest/scripts"
}

wfconfsync()
{
  local dest="WebFaction:/home/zozo"

  syncdir "$dir_dropbox/.config"    "$dest/.config"
  syncdir "$dir_dropbox/etc"        "$dest/etc" --max-delete=0 --exclude='*.sublime-*'
  syncdir "$dir_dropbox/lib"        "$dest/lib" --max-delete=0
  syncdir "$dir_dropbox/share/vim"  "$dest/.local/share/vim"
  syncdir "$dir_dropbox/scripts"    "$dest/scripts"
}

# confsync()
# {
#     local dir_config="$HOME/Dropbox/.config"
#     local dir_scripts="$HOME/Dropbox/scripts"
#     local -a usrflags=("$@")

#     if [[ ${FUNCNAME[1]} == main ]]; then
#         scold "this function cannot be called directly"
#         return 1
#     elif [[ -n $dest && -n $config_filters && -n $script_filters && -d $dir_config && -d $dir_scripts ]]; then
#         syncdir ${usrflags[*]} "$dir_config"  "$dest/${dir_config##*/}"  "${config_filters[@]}"
#         syncdir ${usrflags[*]} "$dir_scripts" "$dest/${dir_scripts##*/}" "${script_filters[@]}"
#     else
#         scold "something went wrong :("
#         return 1
#     fi
# }

# hconfsync()
# {
#     local dest="Hiroko:/Users/zozo"

#     local -a config_filters=(
#         --exclude='.git*'
#         --exclude=alpine/ 
#         --exclude=fish/ 
#         --include=local/Hiroko/
#         --exclude='local/*'
#         --exclude=mintty/
#         --exclude=transmission/
#         --exclude=x11/
#         --exclude=youtube-dl/
#     )

#     local -a script_filters=(
#         --include=countdown.sh
#         --include=fds.sh
#         --include=fixchmod.sh
#         --include=hardware.rb
#         --include=manpdf.sh
#         --include=os.sh
#         --include=tc.sh
#         --include=tinypng.sh
#         --include=install/
#         --include=libexec/
#         --include=login/
#         --include=util/
#         --exclude='*'
#     )

#     confsync \
#         && syncdir "$dir_dropbox/lib" "$dest/lib" --max-delete=1 \
#         && syncdir "$dir_dropbox/etc" "$dest/etc" --max-delete=1
# }

# wfconfsync()
# {
#     local dest="WebFaction:/home/zozo"

#     local -a config_filters=(
#         --exclude='.git*'
#         --exclude=alpine/
#         --exclude=fish/
#         --include=local/web500/
#         --exclude='local/*'
#         --exclude='macos*'
#         --exclude=mintty/
#         --exclude=misc/
#         --exclude=transmission/
#         --exclude=youtube-dl.conf
#     )

#     local -a script_filters=(
#         --include=countdown.sh
#         --include=fds.sh
#         --include=fixchmod.sh
#         --include=os.sh
#         --include=tc.sh
#         --include=tinypng.sh
#         --include=install/
#         --include=login/
#         --include=util/
#         --exclude='*'
#     )

#     confsync \
#         && syncdir "$dir_dropbox/lib" "$dest/lib" \
#                     --max-delete=1 \
#         && syncdir "$dir_dropbox/etc" "$dest/etc" \
#                     --max-delete=0 --exclude='*.sublime-*'
# }
