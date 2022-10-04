function __man_title -d "Print a manpage title in name(section) format"
    set -l manfile (command man -w $argv)
    or return

    set -l match (string match -r '.*/(.+?)\.(.+?)(?:\.gz)?' "$manfile")
    or return

    set -l title $match[2]
    set -l section $match[3]

    echo "$title($section)"
end
