function fish_prompt --description 'Display the interactive prompt'
  if set -q SSH_CONNECTION
    set_color $fish_color_host
    # DEFAULT_USER is set in ~/.private/environment.d/default_user.sh
    if test "$USER" != "$DEFAULT_USER"
      echo -ns $USER "@"
    end
    echo -ns (prompt_hostname) (set_color normal) ":"
  end

  test (id -u) -eq 0; and set -l root_user yes

  set_color $fish_color_cwd
  if set -q root_user # root gets an unobscured path
    echo -n (pwd)
  else
    echo -n (prompt_pwd)
  end

  __fish_prompt_rbenv
  __fish_prompt_git
  __fish_prompt_jobs

  if set -q fish_private_mode
    set_color $fish_color_dimmed
    set glyph "?"
  else if set -q root_user
    set_color $fish_color_user_root
    set glyph "#"
  else
    set_color $fish_color_user
    set glyph "¶"
  end
  echo -ns " $glyph "

  set_color normal
end
