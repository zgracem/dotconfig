# ~/.config/fish/completions

This directory contains custom completion files I've written for `fish` that
supplement or replace the included completions. I saved a lot of tedious typing
thanks to [`help2man`][h2m] and the built-in [`fish_update_completions`][fuc]
utility.

[h2m]: https://www.gnu.org/software/help2man/
[fuc]: https://fishshell.com/docs/current/commands.html#fish_update_completions

***

> Fish automatically searches through any directories in the array variable
> `$fish_complete_path`, and any completions defined are automatically loaded
> when needed. A completion file must have a filename consisting of the name of
> the command to complete and the suffix `'.fish'`.

By default, Fish searches the following directories for completions, using the
first available file that it finds:

* End-users' own completions in `$__fish_config_dir/completions` ← You are here
* Completion files for all users in `$__fish_sysconf_dir/completions`
* Third-party completions in `$__fish_data_dir/vendor_completions.d`
* Files that shipped with fish in `$__fish_data_dir/completions`
* Auto-generated files in `$XDG_DATA_HOME/fish/generated_completions`

***

Completions for my own custom functions (`~/.config/fish/{conf.d,functions}`)
are sourced from [`../packages/zgm-completions`][zc].

[zc]: https://github.com/zgracem/dotconfig/tree/main/fish/packages/zgm-completions
