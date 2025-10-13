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

    if path is -x $XDG_BIN_HOME/fish
        if string match -q "*$fishver" ($XDG_BIN_HOME/fish --version)
            echo >&2 "fish $fishver is already installed!"
            return 1
        end
    end

    set -f arch (uname -m)
    set -f package "fish-$fishver-linux-$arch.tar.xz"
    set -f url "https://github.com/fish-shell/fish-shell/releases/download/$fishver/$package"

    cd (mktemp -d)
    and wget $url
    and unxz -k $package
    and install -D -C ./fish $XDG_BIN_HOME/fish
    and cd ~
    and exec $XDG_BIN_HOME/fish
end
