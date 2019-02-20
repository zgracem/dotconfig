function __fish_prompt_update_window_title --on-event fish_prompt
  __fish_prompt_set_window_title (fish_title)
end

function __fish_prompt_set_window_title
  set BEL "\a"
  set DCS "\eP"
  set OSC "\e]"
  set ST  "\e\\"

  set DCS_ante ""
  set DCS_post ""

  if in-tmux
    set DCS_ante $DCS "tmux;\\e"
    set DCS_post $ST
  end

  set CAP_ts $DCS_ante $OSC "2;"
  set CAP_fs $BEL $DCS_post

  echo -nes $CAP_ts "$argv" $CAP_fs
end
