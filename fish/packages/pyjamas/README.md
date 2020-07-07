# PYJamas

Move comfortably between **P**roperty lists, **Y**AML, and **J**SON (and TOML).

## Usage

```sh
# Convert property list file to JSON
pyjamas --out=json HardToRead.plist

# Works with stdin, just pass -i/--in=FORMAT too
cat v4.yaml | pyjamas -i yaml -o toml > v5.toml
```

## Requirements

* `ruby` must be in your `PATH`.
* TOML support requires [`toml-rb`].

[`toml-rb`]: https://github.com/emancu/toml-rb