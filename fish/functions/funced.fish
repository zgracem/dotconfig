# The way `funced` currently works can result in data loss: specifically, it
# can strip comments, and code outside the main function definition, from any
# file it touches. I'm reluctant to call this a bug in fish but it's definitely
# not behaviour I want, so here's a minimal reimplementation that behaves the
# way I prefer.
function funced -a function --wraps funcsave --description 'Edit a function interactively'
  set -l function_info (functions --details --verbose -- $function)
  set -l function_source $function_info[1]
  set -l function_line $function_info[3]

  switch $function_source
  case 'n/a' '-' 'stdin'
    set function_source "$__fish_config_dir/functions/$function.fish"
  end

  if not test -f $function_source
    if functions -q $function
      functions -- $function | string replace \t "  " >$function_source
    else
      echo -e "function $function --description ''\\n  \\nend" >$function_source
    end
  end

  if test $function_line -gt 1
    if string match -q "*vim" "$VISUAL"
      $VISUAL +$function_line $function_source
    else
      $VISUAL $function_source:$function_line
    end
  else
    $VISUAL $function_source
  end

  if test -f $function_source
    source $function_source
  else
    echo >&2 "file not found: $function_source"
    return 1
  end
end
