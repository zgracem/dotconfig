function op_signin --description "Sign into 1Password's CLI tool"
  argparse 'f/force' -- $argv

  function _1p_
    jq -r ".accounts[0].$argv[1]" $XDG_CONFIG_HOME/.op/config; or return
  end

  set -l my (_1p_ shorthand)
  set -l op_env_var "OP_SESSION_$my"

  if set -q $op_env_var; and not set -q _flag_force
    echo "already signed in, use --force to reauthenticate"
    return
  end

  set -l op_account (_1p_ email)
  set -l op_secret  (_1p_ accountKey)

  set -gx $op_env_var (eval "op signin $my $op_account $op_secret --raw")
end
