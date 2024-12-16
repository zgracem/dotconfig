# ~/.config/homebrew

Files related to installing and configuring [Homebrew](https://brew.sh).

```sh
brew bundle --file=$XDG_CONFIG_HOME/homebrew/Brewfile
```

To set up [command aliases](https://github.com/Homebrew/homebrew-aliases):

```sh
test -L ~/.brew-aliases || ln -sv $XDG_CONFIG_HOME/homebrew/aliases ~/.brew-aliases
```

## See also

[`../env.d/homebrew.env`](https://github.com/zgracem/dotconfig/blob/main/env.d/homebrew.env)
