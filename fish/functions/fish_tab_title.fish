# Called by ~/.config/fish/conf.d/__fish_prompt_update_title.fish
function fish_tab_title --description 'Update the tab title'
  set -q short_hostname
  or set -g short_hostname (string split "." $hostname)[1]

  set -l cwd (short_home "$PWD")
  set -l cwd_parts (string split "/" "$cwd")

  echo -n "$short_hostname:"

  if test (count $cwd_parts) -le 2
    echo -n $cwd
  else
    string join / -- $cwd_parts[1] "…" $cwd_parts[-1]
  end
end
