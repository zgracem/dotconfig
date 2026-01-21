function update-local-fish -a fishver
    set -q XDG_BIN_HOME[1]
    or set -fx XDG_BIN_HOME ~/.local/bin

    if not set -q fishver[1]
        echo >&2 "Usage:" (status function) "X.Y.Z"
        return 2
    end

    if fish-is-newer-than $fishver
        echo >&2 "fish $version is already running!"
        return 1
    end

    if path is -x $XDG_BIN_HOME/fish; and $XDG_BIN_HOME/fish --version | string match -q "*$fishver"
        echo >&2 "fish $fishver is already installed!"
        return 1
    end

    set -f arch (uname -m) # available: aarch64 | x86_64
    set -f package "fish-$fishver-linux-$arch.tar.xz"
    set -f url "https://github.com/fish-shell/fish-shell/releases/download/$fishver/$package"

    cd (mktemp -d)
    and wget --quiet --no-config $url
    and unxz -ck $package | tar xf -
    and install -D -C ./fish $XDG_BIN_HOME/fish
    and cd ~
    and exec $XDG_BIN_HOME/fish
end
