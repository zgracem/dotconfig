# Called by ~/.config/fish/conf.d/__fish_prompt_update_title.fish
function fish_tab_title --description 'Update the tab title'
  set -l cwd (string replace -r "^$HOME(?=\$|/)" "~" $PWD)
  set -l cwd_parts (string split "/" "$cwd")

  if test (count $cwd_parts) -le 2
    echo -n $cwd
  else
    string join / -- $cwd_parts[1] "…" $cwd_parts[-1]
  end
end
