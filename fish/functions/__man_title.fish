function __man_title -d "Print a manpage title in name(section) format"
    set -l manfile (command man -w $argv)
    or return

    path basename $manfile | string replace -rf '\.([^.]+)(?:\.gz)?$' '($1)'
end
