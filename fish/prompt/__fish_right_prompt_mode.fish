function __fish_right_prompt_mode --description 'Display the current mode for the prompt'
  if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
    or [ "$fish_key_bindings" = "fish_hybrid_key_bindings" ]
    switch $fish_bind_mode
      case default
        set -l color blue
        set -l mode 'e'
      case insert
        set -l color green
        set -l mode 'i'
      case replace_one
        set -l color yellow
        set -l mode 'r'
      case visual
        set -l color brblue
        set -l mode 'v'
      case '*'
        set -l color --bold red
        set -l mode '?'
    end
    set_color $color
    echo -n "$mode "
    set_color normal
  end
end
