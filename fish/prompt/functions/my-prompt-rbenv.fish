function my-prompt-rbenv
    command -q rbenv
    or return 0

    set -l vfile (
        set -l pwd_ (string split / $PWD)
        for n in (seq (count $pwd_) -1 1)
            set -l i -$n
            string join / $pwd_[1..$n] .ruby-version \
                | path filter
            and break
        end
    )
    if path is -f $vfile
        read -gx LOCAL_RBENV_VERSION <$vfile
    else
        return
    end

    # GLOBAL_RBENV_VERSION set in $__fish_config_dir/env.d/rbenv.fish
    string match -q "$GLOBAL_RBENV_VERSION" "$LOCAL_RBENV_VERSION"
    and return

    set_color $fish_color_prompt_rbenv
    echo -n $LOCAL_RBENV_VERSION

    set_color normal
    echo -n " "
end
