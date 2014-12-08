# dos2unix
# http://waterlan.home.xs4all.nl/dos2unix.html

_inPath dos2unix || return

dos2unix()
{
    local flags_dos2unix='-k' # copy date stamp to output file

    command dos2unix $flags_dos2unix "$@"
}
