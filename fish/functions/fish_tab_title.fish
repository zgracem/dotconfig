function fish_tab_title --description 'Update the tab title'
  set -l cwd (short_home "$PWD")
  set -l cwd_parts (string split "/" "$cwd")

  echo -ns (prompt_hostname) ":"

  if test (count $cwd_parts) -le 2
    echo -n $cwd
  else
    string join / -- $cwd_parts[1] "…" $cwd_parts[-1]
  end
end
