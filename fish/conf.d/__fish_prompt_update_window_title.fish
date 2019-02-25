function __fish_prompt_update_window_title --on-event fish_prompt
  __fish_prompt_set_window_title (fish_title)
end

function __fish_prompt_set_window_title -a title
  set -l BEL "\a"
  set -l DCS "\eP"
  set -l OSC "\e]"
  set -l ST  "\e\\"

  set -l DCS_ante ""
  set -l DCS_post ""

  if in-tmux
    set DCS_ante $DCS "tmux;\\e"
    set DCS_post $ST
  end

  set -l CAP_ts $DCS_ante $OSC "2;"
  set -l CAP_fs $BEL $DCS_post

  echo -nes $CAP_ts "$title" $CAP_fs
end
