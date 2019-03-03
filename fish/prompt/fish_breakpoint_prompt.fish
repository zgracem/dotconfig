function fish_breakpoint_prompt --description 'A prompt to be used when `breakpoint` is executed'
  set -l last_exit $status
  set -l glyph 'Ϟ'

  set -l function (status -L0 function)

  # # These do not return useful information as of fish 3.0.2 -- ZGM 2019-03-03
  # set -l lineno (status -L0 line-number)
  # set -l filename (status -L0 filename | string split /)[-1]

  if [ -z "$function" -o "$function" = 'Not a function' ]
    set function 'main'
  end

  if [ $last_exit -ne 0 ]
    set_color $fish_color_error
  else
    set_color $fish_color_status
  end
  echo -n $glyph

  set_color $fish_color_dimmed
  echo -n " $function() "

  echo -ns (set_color $fish_color_status) "»" (set_color normal) " "
end
