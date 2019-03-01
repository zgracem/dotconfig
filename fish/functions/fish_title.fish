# See also ~/.config/fish/conf.d/__fish_prompt_update_title.fish
function fish_title --description 'Update the window title'
  set -q long_hostname
  or set -g long_hostname (/bin/hostname -f 2>/dev/null)
  or set -g long_hostname $hostname

  printf "%s@%s: %s" $USER $long_hostname (pwd | string replace -r "^$HOME" "~")

  set -l cur_cmd (status current-command 2>/dev/null)
  or return

  if not string match -rq '.*/?\bfish' $cur_cmd
    and not set -q ITERM_SESSION_ID
    printf " [%s]" (status current-command)
  end
end
