# Sublime Merge settings

Setup:

```bash
conf="$XDG_CONFIG_HOME/smerge"
priv="$XDG_CONFIG_HOME/../.private/smerge"
apps="$HOME/Library/Application Support/Sublime Merge"

ln -sf "$priv/Local/License.sublime_license" "$apps/Local"
for file in "$conf/Packages/User/"*.sublime-settings; do
  ln -sf "$file" "$apps/Packages/User"
done
```
