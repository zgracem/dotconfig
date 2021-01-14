# PYJamas

Move comfortably between **P**roperty lists, **Y**AML, and **J**SON (and TOML).

## Usage

```fish
# Convert property list file to YAML
pyjamas -o yaml HardToRead.plist

# For non-obvious file extensions, pass -i/--in=FORMAT
pyjamas --in toml --out json ~/.example/config | jq ...

# Works on stdin too; -m/--mode=IN:OUT is handy here
cat version_4.yaml | pyjamas --mode yaml:toml >version_5.toml
```

## Requirements

* `ruby` must be in your `PATH`.
* Property list support requires [`plist`].
* TOML support requires [`toml-rb`].

[`plist`]: https://github.com/bleything/plist
[`toml-rb`]: https://github.com/emancu/toml-rb
