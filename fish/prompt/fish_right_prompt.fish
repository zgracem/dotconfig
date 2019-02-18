function fish_right_prompt --description 'Display the right side of the interactive prompt'
  set -l exit $status

  if test $exit -ne 0
    set_color $__fish_prompt_color_exit
    echo -s (__fish_right_prompt_signal $exit) " "
    set_color normal
  end

  # if test $fish_key_bindings = "fish_vi_key_bindings"
  #   __fish_right_prompt_mode
  # end

  # if test $COLUMNS -gt 132
  #   set_color $__fish_prompt_color_clock
  #   echo -s (date +%T) " "
  #   set_color normal
  # end
end
