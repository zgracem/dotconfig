function op-signin --description "Sign into 1Password's CLI tool"
    argparse f/force -- $argv

    set -l me (jq -r ".accounts[0].userUUID" $XDG_CONFIG_HOME/.op/config)
    set -l op_env_var "OP_SESSION_$me"

    if set -q $op_env_var; and not set -q _flag_force
        echo "already signed in, use --force to reauthenticate"
        return
    end

    set -gx $op_env_var (eval "op signin --account personal --raw")
end
