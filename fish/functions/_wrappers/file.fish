function file -d "Determine file type"
    set -p argv -p # don't touch last-accessed time

    command file $argv
end
