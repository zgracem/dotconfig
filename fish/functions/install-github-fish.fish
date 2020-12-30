function install-github-fish
    set -l prev_wd $PWD
    set -l src_dir "$HOME/.local/src/github.com/fish-shell"
    set -l build_dir "$src_dir/build"
    set -l fish_prefix "$HOME/opt/stow/fish-HEAD"
    set -l install__fish_data_dir "$fish_prefix/share/fish"

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

    cmake .. -DCMAKE_INSTALL_PREFIX=$fish_prefix; or return

    make
    and make install
    or return

    set -l fish_completions_dir (pkg-config --variable completionsdir fish); or return
    set -l vendor_completions_dir $fish_prefix/share/fish/vendor_completions.d
    if test (count $vendor_completions_dir/*.fish) -eq 0
        command mkdir -p (dirname $vendor_completions_dir)
        command rm -rf $vendor_completions_dir
        command ln -s $fish_completions_dir $vendor_completions_dir; or return
    end

    cd "$prev_wd"
end
