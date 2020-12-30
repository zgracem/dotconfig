function install-github-fish
    set -l prev_wd $PWD
    set -l src_dir "$HOME/.local/src/github.com/fish-shell"
    set -l build_dir "$src_dir/build"
    set -l fish_prefix "$HOME/opt/stow/fish-HEAD"

    __install-github-fish_git-acquire
    or return

    __install-github-fish_unstow
    or return

    __install-github-fish_make-fish
    or return

    __install-github-fish_link-completions

    __install-github-fish_stow
    or return

    cd "$prev_wd"
end

function __install-github-fish_git-acquire
    if test -d "$src_dir/.git"
        rm -rf "$build_dir" >/dev/null
        cd "$src_dir"; or return
        git pull --force; or return
    else
        mkdir -p "$src_dir"; or return
        cd "$src_dir"; or return
        git clone git@github.com:fish-shell/fish-shell.git; or return
    end
end

function __install-github-fish_make-fish
    mkdir -p "$build_dir"; and cd "$build_dir"; or return
    cmake .. -DCMAKE_INSTALL_PREFIX=$fish_prefix; or return
    make
    and make install
end

function __install-github-fish_link-completions
    set -l fish_completions_dir (pkg-config --variable completionsdir fish); or return
    set -l vendor_completions_dir $fish_prefix/share/fish/vendor_completions.d
    if test (count $vendor_completions_dir/*.fish) -eq 0
        command mkdir -p (dirname $vendor_completions_dir)
        command rm -rf $vendor_completions_dir
        command ln -s $fish_completions_dir $vendor_completions_dir; or return
    end
end

function __install-github-fish_unstow
    cd "$fish_prefix/.."
    and stow --delete (basename $fish_prefix)
end

function __install-github-fish_stow
    cd "$fish_prefix/.."
    and stow (basename $fish_prefix)
end
