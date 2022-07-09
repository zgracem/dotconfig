function no-macos-drive
    set -l url "http://blog.hostilefork.com/trashes-fseventsd-and-spotlight-v100/"
    echo "This file disables Spotlight indexing for this drive."\n$url > .metadata_never_index
    realpath .metadata_never_index
    echo "This file disables macOS's Trash for this drive."\n$url > .Trashes
    realpath .Trashes
end
