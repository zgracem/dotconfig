(( ${BASH_VERSINFO[0]}${BASH_VERSINFO[1]} >= 44 )) || return

v()
{
  if [[ $1 =~ ^[[:alpha:]][[:alnum:]_]*$ && -n ${!1} ]]; then
    # If $1 looks like a valid parameter name -- which we need to check first,
    # or bash could throw a "bad substutition" error -- and names a parameter
    # that's been set, print its contents as "an assignment statement... that, 
    # if evaluated, will recreate [the] parameter."
    local var="${!1}"
    echo "${!1@A}"
  else
    # Print all arguments "quoted in a format that can be reused as input."
    local input=${@:-$(</dev/stdin)}
    echo "${input@Q}"
  fi
}
