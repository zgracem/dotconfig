# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# colour definitions (requires colout: https://github.com/nojhan/colout)
# ------------------------------------------------------------------------------

colour_functionFile=blue
colour_functionLine=cyan
colour_aliasName=green
colour_aliasValue=yellow
colour_builtin=cyan
colour_keyword=blue
colour_specialDef=none
colour_fileName=none
colour_filePath=green

# ------------------------------------------------------------------------------
# which(): a better version of `type` -- with colouring!
# ------------------------------------------------------------------------------

fprint()
{   # fancy print function
    # Usage: fprint "output string" [colout options]

    declare output="$1" regex="$2"; shift 2

    _inPath colout && {
        builtin printf "%s\n" "$output" | colout "$regex" $*
    } || {
        builtin printf "%s\n" "$output"
    }
}

whichfunction()
{
    [[ $BASHOPTS =~ extdebug ]] || {
        declare extdebug=true
        shopt -s extdebug
    }

    declare func="$1" sourceFile lineNo
    sourceFile="$(declare -F $func | cut -d" " -f3-)"
    lineNo="$(declare -F $func | cut -d" " -f2)"

    fprint "${sourceFile}:${lineNo}" "(.+):([0-9]+)" \
        $colour_functionFile,$colour_functionLine normal

    fprint "$(declare -f "$func" | tail -n +1)" -s bash

    [[ $extdebug ]] &&
        shopt -u extdebug
}

whichalias()
{
    declare name="$1" target ERE

    _isGNU sed && ERE=r || ERE=E

    target="$(alias $name | sed -$ERE \
        -e "s/^.+='//" \
        -e "s/'$//" \
        -e "s/\\\''//g")"

    fprint "$name is aliased to \`$target'" "(^$name).*\`(.+)'$" \
        $colour_aliasName,$colour_aliasValue normal
}

whichspecial()
{
    declare name="$1" thingType="$2" desc colour

    case $thingType in
        builtin)
            thingType="shell builtin"
            colour=$colour_builtin
            ;;
        keyword)
            colour=$colour_keyword
            ;;
    esac

    desc="$name is a $thingType"

    printf -v name "%q" "$name"

    fprint "$desc" "(^$name) is a (.+)$" \
        $colour,$colour_specialDef normal
}

whichbuiltin() { whichspecial "$1" builtin; }
whichkeyword() { whichspecial "$1" keyword; }

whichfile()
{
    declare name="$1" fileName
    declare -a fileNames=($(builtin type -ap $name))

    for fileName in ${fileNames[@]}; do
        fprint "$name is $fileName" "(^$name) is (.+)$" \
            $colour_fileName,$colour_filePath normal
    done
}

which()
{
    declare thing="$1" thingType
    declare -a thingTypes=($(builtin type -at $thing | uniq))

    [[ ${#thingTypes[@]} -gt 0 ]] || {
        printf "%s: %s: not found\n" $FUNCNAME "$thing" 1>&2
        return 1
    }

    for thingType in ${thingTypes[@]}; do
        case $thingType in
            function|alias|builtin|keyword)
                which${thingType} "$thing"
                ;;
            file)
                whichfile "$thing"
                ;;
        esac
    done
}

# ------------------------------------------------------------------------------

what()
{   # automatic documentation for shell commands
    # based on http://crunchbanglinux.org/forums/post/131229/#p131229
    declare thing="$1"
    declare thingType="$(type -t "$thing")" || {
        printf "%s: '%s' not recognized\n" $FUNCNAME "$thing" 1>&2
        return 1
    }

    case "$thingType" in
        alias|function)
            which "$thing"
            ;;
        builtin|keyword)
            help -m "$thing" | $PAGER
            ;;
        file)
            case $(file --mime --dereference --brief --preserve-date $(type -p "$thing")) in
                application/*)
                    if command man -w "$thing" &>/dev/null; then
                        man "$thing"
                    else
                        printf "%s: '%s' compiled executable or unsupported format\n" $FUNCNAME "$thing" 1>&2
                        printf "No man page installed for %s. Try \`%s --help\` or \`-h\`." "$thing" 1>&2
                    fi
                    ;;
                *)  file --no-dereference --preserve-date --uncompress "$thing"
                    ;;
            esac
            ;;
    esac
}

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
