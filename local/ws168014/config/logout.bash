# ------------------------------------------------------------------------------
# WS168014:~/.local/logout.bash
# ------------------------------------------------------------------------------

subl_dir="${dir_apps}/Sublime Text 3/Data"
save_dir="${dir_dropbox}/Archive/WS144966"

sessions_file="${subl_dir}/Local/Auto Save Session.sublime_session"
save_file="$save_dir/Auto Save Session.sublime_session"
# save_file="$save_dir/$(command date +%F_%H.%M.%S).sublime_session"

if [[ -r $sessions_file && -d $save_dir ]]; then
  command cp -af "$sessions_file" "$save_file"
fi
