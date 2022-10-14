function __fish_prompt_rbenv
    in-path rbenv
    or return 0

    if not set -q GLOBAL_RBENV_VERSION
        set -l vfile $RBENV_ROOT/version
        if not path is -f $vfile
            mkdir -pv (dirname $vfile)
            and rbenv global >$vfile
        end
        read -g GLOBAL_RBENV_VERSION <$vfile
    end
    set -g LOCAL_RBENV_VERSION (rbenv version | string split -f1 " ")

    string match -q "$GLOBAL_RBENV_VERSION" "$LOCAL_RBENV_VERSION"
    and return

    set_color $fish_prompt_color_rbenv
    echo -n $LOCAL_RBENV_VERSION

    set_color normal
    echo -n " "
end
