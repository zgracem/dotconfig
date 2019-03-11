if not set -q ENV; and string match -q '*fish' "$SHELL"
  # Use sh(1) to populate the environment from ~/.config/environment.d.
  # Both the -l and -i flags are needed to prevent an infinite loop.
  set -l params -c "exec $SHELL"

  status is-login; and set params -l $params
  status is-interactive; and set params -i $params

  exec sh $params
end
