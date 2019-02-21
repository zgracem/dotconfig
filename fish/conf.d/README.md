# ~/.config/fish/conf.d

`.fish` files in this directory override those in `$__fish_data_dir/conf.d` and
`$__fish_sysconf_dir/conf.d`, and are sourced before the contents of
`$__fish_config_dir/config.fish`.

Use this directory for configuration that needs to be available before or
while `config.fish` is sourced, and for functions that cannot be autoloaded
(event handlers, function name/filename mismatches, files with multiple 
functions...).
