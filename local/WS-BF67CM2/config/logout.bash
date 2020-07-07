# ------------------------------------------------------------------------------
# WS168014:~/.local/logout.bash
# ------------------------------------------------------------------------------

sessions_dir="${APPLICATIONS}/Sublime Text 3/Data/Local"
save_dir="${HOME}/Dropbox/Archive/WS168014"
file_basename="Auto Save Session.sublime_session"

sessions_file="${sessions_dir}/${file_basename}"
save_file="${save_dir}/${file_basename}"
# save_file="$save_dir/$(command date +%F_%H.%M.%S).sublime_session"

if [[ -r $sessions_file && -d $save_dir ]]; then
  command cp -af "$sessions_file" "$save_file"
fi
