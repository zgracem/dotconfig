# notes.fish

```fish
# Binaries I need in ~/.rbenv/shims
set rbenv_shims bundle erb gem rake ronn rubocop ruby slim-lint slimrb solargraph

# How to upgrade various package managers

brew upgrade

gem update --system; and gem update

npm update npm -g; and npm update -g
and brew unlink node; and brew link --overwrite node

for pkg in pip (pip list --outdated --format=freeze | string split -f1 ==)
    pip install -U "$pkg"
end

# mkvextract: Extract subtitles

set -l track_id (mkvmerge --identify $mkv_file | ag -m1 subtitles)
and set -l sub_file (path change-extension .srt "$mkv_file")
and mkvextract tracks $mkv_file $track_id:$sub_file

# ffmpeg: Extract 1m23s of audio from input.m4a starting at 4:56

ffmpeg -ss 00:04:56 -i "input.m4a" -vn -c copy -t 00:01:23 "output.m4a"
# -ss: seek here in seconds
# -i : input file
# -vn: no video (if present)
# -c : copy stream?
# -t : restrict to this length

# Sort lines by length

cat whatever.txt | awk '{print length,$0}' | sort -n | string split -m2 -f3 " "

# macOS: get clipboard contents as HTML

osascript -e 'try' -e 'get the clipboard as «class HTML»' -e 'end try' \
        | string match --regex --groups-only '«data .{4}(.+)»' \
        | xxd -revert -plain

# macOS: get the bundle ID of an application

osascript -e 'id of app "VMWare Fusion"' #=> com.vmware.fusion

# macOS: reset QuickLook

qlmanage -r; and qlmanage -r cache; and killall Finder

# macOS: clean up Launch Services database

set -p PATH /System/Library/Frameworks/CoreServices.framework/Frameworks/LaunchServices.framework/lsregister
lsregister -v -kill -r -domain local,system,user; and killall Finder

# macOS: install a .pkg (arg to `-target` must be a mounted volume)

installer -pkg $HOME/Downloads/installer.pkg -target /

# macOS: reinstall broken Xcode Command Line Tools

sudo rm -rf /Library/Developer/CommandLineTools
xcode-select --install

# fish: list all functions without descriptions

function describe -a f; functions -Dv $f | string join0 | string split0 -f5; end
for function in (functions -n)
    set -l description (describe $function)
    string match -q n/a "$description"; and echo $function
end

# npm: fix 'ERR! Invalid package name ".DS_Store"':

find $XDG_DATA_HOME/npm -name .DS_Store -type f -print -delete

```

## bash: files, strings, and streams

```sh
# Use command output as a string (command substitution)

    echo "Today is $(date +%F)."

# Use the contents of a file as a string (command substitution)

    # Good:
    var=$(<stuff.txt)
    # Bad:
    var=$(cat stuff.txt)

# Use a string as a file (here strings)

    # Good:
    grep "$pattern" <<< "$string"
    # Bad:
    echo "$string" | grep "$pattern"

# Use command output as a file (process substitution)

    diff <(curl http://example.com) <(curl http://example.org)

# Accept both `moo "string"` and `moo < file`

    moo() { local input=${*:-$(</dev/stdin)}; cowsay "$input"; }

# Display command output while capturing it in a variable

    stdin=$(tty) && today=$(date +%F | tee "$stdin")
```
