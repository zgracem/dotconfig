function no-macos-drive -d "Prevent macOS from writing metadata"
    set -q argv[1]; and cd $argv[1]
    if string match -vq /Volumes (path resolve $PWD/..)
        echo >&2 (path resolve $PWD/..)" is not the root directory of a removeable drive!"
        return 1
    end

    set -l url "http://blog.hostilefork.com/trashes-fseventsd-and-spotlight-v100/"

    # "Although you *can* do this for .fseventsd, and it will technically stop
    # file system events from being logged, this is probably not worthwhile...
    # since by the time you eject a disk this file should be empty. And you'll
    # really just be breaking notifications of file system events on macs while
    # it's plugged in."

    if path is -d $PWD/.Spotlight-V100
        command rm -rfv $PWD/.Spotlight-V100
    end

    if path is -f $PWD/.metadata_never_index
        echo $PWD/.metadata_never_index: File exists
    else
        echo "This file disables Spotlight indexing for this drive."\n$url >.metadata_never_index
        and echo Wrote $PWD/.metadata_never_index
    end

    if path is -d $PWD/.Trashes
        command rm -rfv $PWD/.Trashes
    else if path is -f $PWD/.Trashes
        echo $PWD/.Trashes: File exists
    else
        echo "This file disables macOS's Trash for this drive."\n$url >.Trashes
        and echo Wrote $PWD/.Trashes
    end

    cd -
end
