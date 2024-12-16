# ~/.config/homebrew

Files related to installing and configuring [Homebrew](https://brew.sh).

To install everything in [`Brewfile`](https://github.com/Homebrew/homebrew-bundle#usage):

```sh
brew bundle --file=$XDG_CONFIG_HOME/homebrew/Brewfile
```

To set up [command aliases](https://github.com/Homebrew/homebrew-aliases):

```sh
test -L ~/.config/brew-aliases || ln -sv ~/.config/homebrew/aliases ~/.config/brew-aliases
```

## See also

* [`../env.d/homebrew.env`](https://github.com/zgracem/dotconfig/blob/main/env.d/homebrew.env)
* [`../homebrew/brew.env`](https://github.com/zgracem/dotconfig/blob/main/homebrew/brew.env)
