function install-github-fish
    set src_dir "$HOME/.local/src/github.com/fish-shell"
    set build_dir "$src_dir/build"
    set install_dir "$HOME/opt/stow/fish-HEAD"

    if test -d "$src_dir/.git"
        rm -rf "$build_dir" >/dev/null
        cd "$src_dir"; or return
        git pull --force; or return
    else
        mkdir -p "$src_dir"; or return
        cd "$src_dir"; or return
        git clone git@github.com:fish-shell/fish-shell.git; or return
    end

    mkdir -p "$build_dir"; and cd "$build_dir"; or return

    cmake .. -DCMAKE_INSTALL_PREFIX=$install_dir; or return

    make
    and make install
end
