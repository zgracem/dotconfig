function op-signin --description "Sign into 1Password's CLI tool"
    argparse f/force -- $argv

    function _1p_
        jq -r ".accounts[0].$argv[1]" $XDG_CONFIG_HOME/.op/config; or return
    end

    set -l me (_1p_ userUUID)
    set -l op_env_var "OP_SESSION_$me"

    if set -q $op_env_var; and not set -q _flag_force
        echo "already signed in, use --force to reauthenticate"
        return
    end

    set -gx $op_env_var (eval "op signin --account personal --raw")
end
