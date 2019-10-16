function fish_prompt --description 'Display the interactive prompt'
  if set -q SSH_CONNECTION
    set_color $fish_color_host
    # DEFAULT_USER is set in ~/.private/environment.d/default_user.sh
    if test "$USER" != "$DEFAULT_USER"
      echo -ns $USER "@"
    end
    echo -ns (prompt_hostname) (set_color normal) ":"
  end

  set_color $fish_color_cwd
  if test (id -u) -eq 0 # root gets an unobscured path
    echo -n (pwd)
  else
    echo -n (prompt_pwd)
  end

  __fish_prompt_git
  __fish_prompt_jobs

  if set -q fish_private_mode
    set_color $fish_color_dimmed
    set glyph "?"
  else if test (id -u) -ne 0
    set_color $fish_color_user
    set glyph "¶"
  else
    set_color $fish_color_user_root
    set glyph "#"
  end
  echo -ns " $glyph "

  set_color normal
end
