function no-macos-drive -d "Prevent macOS from writing metadata"
    if string match -vq /Volumes (path resolve $PWD/..)
        echo >&2 "This is not the root directory of a removeable drive!"
        return 1
    end

    set -l url "http://blog.hostilefork.com/trashes-fseventsd-and-spotlight-v100/"

    echo "This file disables Spotlight indexing for this drive."\n$url >.metadata_never_index
    and realpath .metadata_never_index

    echo "This file disables macOS's Trash for this drive."\n$url >.Trashes
    and realpath .Trashes
end
