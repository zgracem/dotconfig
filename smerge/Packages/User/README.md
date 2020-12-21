# Sublime Merge settings

Setup:

```bash
dbc="$HOME/Dropbox/.config/smerge"
dbp="$HOME/Dropbox/.private/smerge"
las="$HOME/Library/Application Support/Sublime Merge"

ln -sf "$dbp/Local/License.sublime_license" "$las/Local"
for file in "$dbc/Packages/User/"*.sublime-settings; do
  ln -sf "$file" "$las/Packages/User"
done
```
