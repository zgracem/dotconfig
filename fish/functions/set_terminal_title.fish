function set_terminal_title --description 'Set the xterm-compatible terminal title'
  argparse -n set_terminal_title --min-args 1 --exclusive window,tab,both 'w/window' 't/tab' 'b/both' -- $argv

  set -l BEL "\a"
  set -l DCS "\eP"
  set -l OSC "\e]"
  set -l ST  "\e\\"

  set -l dcs_ante ""
  set -l dcs_post ""

  if in-tmux
    set dcs_ante $DCS "tmux;\\e"
    set dcs_post $ST
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

  set -l tcap_ts $dcs_ante $OSC "$Ps;"
  set -l tcap_fs $BEL $dcs_post

  echo -ens $tcap_ts $argv[1] $tcap_fs
end
