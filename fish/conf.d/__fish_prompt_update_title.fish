function __fish_prompt_update_title --on-event fish_prompt
  __fish_prompt_set_title --window (fish_title)
end

function __fish_prompt_set_title
  argparse --min-args 1 --exclusive window,tab,both 'w/window' 't/tab' 'b/both' -- $argv

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

  set -l Ps
  if set -q _flag_window
    set Ps 2
  else if set -q _flag_tab
    set Ps 1
  else if set -q _flag_both
    set Ps 0
  else
    echo >&2 "failed to specify which title to set"
    return 121
  end

  set -l CAP_ts $DCS_ante $OSC "$Ps;"
  set -l CAP_fs $BEL $DCS_post

  echo -ens $CAP_ts $argv[1] $CAP_fs
end
