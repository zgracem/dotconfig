# ~/.config/fish/completions

> Fish automatically searches through any directories in the array variable
> `$fish_complete_path`, and any completions defined are automatically loaded
> when needed. A completion file must have a filename consisting of the name of
> the command to complete and the suffix `'.fish'`.

By default, Fish searches the following directories for completions, using the
first available file that it finds:

* End-users' own completions in `$__fish_config_dir/completions` (this dir)
* Completion files for all users in `$__fish_sysconf_dir/completions`
* Third-party completions in `$__fish_data_dir/vendor_completions.d`
* Files that shipped with fish in `$__fish_data_dir/completions`
* Auto-generated files in `~/.local/share/fish/generated_completions`
