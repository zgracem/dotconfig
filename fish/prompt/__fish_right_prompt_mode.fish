function __fish_right_prompt_mode --description 'Display the current mode for the prompt'
  if [ "$fish_key_bindings" = "fish_vi_key_bindings" ]
    or [ "$fish_key_bindings" = "fish_hybrid_key_bindings" ]
    switch $fish_bind_mode
      case default
        set_color blue
        echo -n 'e'
      case insert
        set_color green
        echo -n 'i'
      case replace_one
        set_color yellow
        echo -n 'r'
      case visual
        set_color brblue
        echo -n 'v'
      case '*'
        set_color --bold red
        echo -n '?'
    end
    set_color normal
    echo -n ' '
  end
end
