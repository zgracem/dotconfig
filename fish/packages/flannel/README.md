# `flannel`

No more fussing with binary .plists or squinting at XML: `flannel` uses
[`pyjamas`] (get it?) to make working with macOS preference files as easy as
hand-editing a YAML file.

[`pyjamas`]: ../pyjamas

## Usage

All commands accept the flag `-n|--dry-run` to only print what would be done
without actually executing.

```fish
# write preferences to $PWD/com.apple.Finder.yaml
flannel dump com.apple.Finder

# import preferences from $FLANNEL_DRAWER/com.rogueamoeba.Fission.yaml
flannel import com.rogueamoeba.Fission

# export preferences from TextEdit's domain to stdout
flannel export com.apple.TextEdit

# print properly list to stdout as YAML
flannel print ~/Documents/com.flyingmeat.Acorn6.plist

# create empty .yaml files in $FLANNEL_DRAWER
flannel touch com.apple.{Dock,Finder,systemuiserver}
```

## TODO

* `flannel dump` currently unconditionally overwrites existing files.
  Add a `--force` flag and change its destination back to `FLANNEL_DRAWER`.
* Better verbs? (`dump`, `export`, and `print` aren't especially evocative
  of their distinct functionality)
