function __fish_prompt_rbenv
    in-path rbenv
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
        ## this is very slow!
        # set -gx LOCAL_RBENV_VERSION (rbenv version | string split -f1 " ")
    end

    # string match -q "$GLOBAL_RBENV_VERSION" "$LOCAL_RBENV_VERSION"
    # and return

    set_color $fish_prompt_color_rbenv
    echo -n $LOCAL_RBENV_VERSION

    set_color normal
    echo -n " "
end
