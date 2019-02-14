function fish_prompt --description 'Display the interactive prompt'
  if not set -q short_hostname
    set -g short_hostname (uname -n | string match -r "[^.]+")
  end

  if set -q SSH_CONNECTION
    echo -ns (set_color $fish_color_host) $short_hostname (set_color normal) ":"
  end

  __fish_prompt_pwd
  __fish_prompt_git
  __fish_prompt_jobs

  echo -n (set_color $fish_color_user) "¶" (set_color normal)
end
