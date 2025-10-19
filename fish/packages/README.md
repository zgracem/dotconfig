# ~/.config/fish/packages

When `../packages.fish` is loaded, the contents of these subdirectories are
automatically treated as though they were directly under `$__fish_config_dir`:

1. Each `.fish` file in `$pkgdir/conf.d` is sourced immediately.
2. If present, `$pkgdir/functions` is added to `$fish_function_path`.
3. If present, `$pkgdir/completions` is added to `$fish_complete_path`.
4. Finally, if present, `$pkgdir/init.fish` is sourced.

If any file in `$pkgdir/conf.d` returns exit code 101, the package is assumed to
have "bootstrapped" itself, and the remaining steps will be skipped.

Additional package directories can be added to the global `$fish_package_path`
variable in `../config.fish` before `../packages.fish` is loaded. Modifying
`$fish_package_path` while the shell is running has no effect.
