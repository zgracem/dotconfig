function __fish_right_prompt_mode --description 'Display the current mode for the prompt'
  if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
    or [ "$fish_key_bindings" = "fish_hybrid_key_bindings" ]
    switch $fish_bind_mode
      case default
        set_color blue
        set -l mode 'e'
      case insert
        set_color green
        set -l mode 'i'
      case replace_one
        set_color yellow
        set -l mode 'r'
      case visual
        set_color brblue
        set -l mode 'v'
      case '*'
        set_color --bold red
        set -l mode '?'
    end
    set_color normal
    echo -n "$mode "
  end
end
