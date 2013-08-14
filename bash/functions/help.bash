# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# colour definitions (requires colout: https://github.com/nojhan/colout)
# ------------------------------------------------------------------------------

colour_functionName=blue
colour_functionFile=blue
colour_functionLine=cyan
colour_aliasName=green
colour_aliasValue=cyan
colour_specialName=yellow
colour_builtin=$colour_specialName
colour_keyword=$colour_specialName
colour_specialDef=none
colour_fileName=none
colour_filePath=cyan

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

where()
{   # ...was this function defined?
    declare func="$1"

    declare -f $func 1>/dev/null || {
        printf "%s: %s: function not found\n" $FUNCNAME $func 1>&2
        return 1
    }

    [[ $BASHOPTS =~ extdebug ]] || {
        declare extdebug=true
        shopt -s extdebug
    }

    declare -F $func | sed -E "s/^$func ([[:digit:]]+) (.*)$/\2:\1/"

    [[ $extdebug ]] &&
        shopt -u extdebug
}

whichfunction()
{
    declare func="$1" location
    location="$(where "$func")" || return 1

    fprint "$location" "(.+):([0-9]+)" \
        $colour_functionFile,$colour_functionLine normal

    fprint "$(declare -f "$func" | tail -n +1)" -s bash
}

whichalias()
{
    declare name="$1" target

    target="$(alias $name 2>/dev/null |
        sed -E "s/(^.+=')|(\\\'')|('$)//g")" # strip and unescape single quotes

    [[ $target ]] || return 1

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

    [[ ${#fileNames[@]} -gt 0 ]] || return 1

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
        which${thingType} "$thing"
    done
}

# ------------------------------------------------------------------------------

what()
{   # provide a synopsis of $1
    declare thing="$1"
    declare helpString failString='nothing appropriate$'

    # is it in the whatis database?
    helpString="$(whatis "$thing" |
        grep "^$thing\>" -m1 |
        sed -E "s/^($thing)[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/\1\2: \3/g")"

    [[ $helpString && ! $helpString =~ $failString ]] && {
        fprint "$helpString" "^$thing" \
            $colour_fileName normal
        return 0
    }

    # then what is it?
    declare -a thingTypes=($(builtin type -at $thing | uniq))

    [[ ${#thingTypes[@]} -gt 0 ]] || {
        printf "%s: %s: not found\n" $FUNCNAME "$thing" 1>&2
        return 1
    }

    for thingType in ${thingTypes[@]}; do
        case "$thingType" in
            alias)
                whichalias "$thing"
                ;;
            function)
                fprint "$thing is a function" "^$thing" \
                    $colour_functionName normal
                ;;
            builtin|keyword)
                helpString="$(builtin help -d "$thing" 2>/dev/null)" &&
                    fprint "$thing ($thingType): ${helpString#* - }" "^$thing" \
                        $colour_specialName normal
                ;;
            file)
                whichfile "$thing"
                ;;
        esac
    done
}

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
