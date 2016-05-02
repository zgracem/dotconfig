if type -P gem &>/dev/null; then
    GEM_HOME=$(gem env home 2>/dev/null) || return
    if [[ -d $GEM_HOME/bin ]] && [[ ! :$PATH: =~ :$GEM_HOME/bin: ]]; then
        PATH=$PATH:"$GEM_HOME/bin"
    fi
    unset -v GEM_HOME
fi
