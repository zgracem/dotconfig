function ef -a function --wraps funcsave --description 'Edit a function interactively'
  set -l function_info (functions --details --verbose -- $function)
  set -l function_source $function_info[1]
  set -l function_line $function_info[3]

  switch $function_source
  case 'n/a' '-'
    set function_source "$__fish_config_dir/functions/$function.fish"
  end

  if functions -q $function; and not test -f $function_source
    functions -- $function >$function_source
  end

  if test $function_line -gt 1
    set function_source "$function_source:$function_line"
  end

  if $VISUAL $function_source
    and test -f $function_source
    source (string split : "$function_source")[1]
  else
    echo >&2 "editor failed or was cancelled"
    return $status
  end
end
