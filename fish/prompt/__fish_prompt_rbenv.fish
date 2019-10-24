function __fish_prompt_rbenv
  command -q rbenv; or return
  set -l global_version (cat ~/.rbenv/version)
  set -l local_version (rbenv version | string split " ")[1]

  if test "$global_version" != "$local_version"
    set_color $fish_prompt_color_ruby
    echo -n " $local_version"
    set_color normal
  end
end
