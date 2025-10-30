function ardir -d "Create an archive from a directory"
    set -l type zip
    set -q argv[2]; and set -f type $argv[2]
    mkar $argv[1].$type $argv[1]/
end
