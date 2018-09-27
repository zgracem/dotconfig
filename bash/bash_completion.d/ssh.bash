# Complete SSH hostnames from ~/.ssh/config, ignoring wildcards
# >> https://sanctum.geek.nz/cgit/dotfiles.git/tree/bash/bash_completion.d/_ssh_config_hosts.bash

__z_complete_ssh_hosts()
{
  COMPREPLY=()

  local -a hosts
  mapfile -t hosts < <(sed -nE 's/\<Host ([^?*]+)$/\1/p' "$HOME/.ssh/config") \
    || return

  local host
  for host in "${hosts[@]}"; do
    [[ $host == "${COMP_WORDS[COMP_CWORD]}"* ]] || continue
    COMPREPLY+=("$host")
  done
}

complete -o default -F __z_complete_ssh_hosts -- ssh
