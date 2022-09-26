function __fish_prompt_rbenv
    in-path rbenv
    or return 0

    set -q GLOBAL_RBENV_VERSION
    or read -g GLOBAL_RBENV_VERSION <$XDG_DATA_HOME/rbenv/version
    set -g LOCAL_RBENV_VERSION (rbenv version | string split -f1 " ")

    string match -q "$GLOBAL_RBENV_VERSION" "$LOCAL_RBENV_VERSION"
    and return

    set_color $fish_prompt_color_ruby
    echo -n $LOCAL_RBENV_VERSION

    set_color normal
    echo -n " "
end
