# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# colour -- requires colout: https://github.com/nojhan/colout
# ------------------------------------------------------------------------------

_inPath colout && {
    colour_punct=white

    colour_aliasName=yellow
    colour_aliasValue=cyan

    colour_functionName=blue
    colour_functionFile=green
    colour_functionLine=yellow

    colour_specialName=magenta
    colour_specialDef=none
    colour_builtin=$colour_specialName
    colour_keyword=$colour_specialName

    colour_fileName=yellow
    colour_filePath=green

    colour_varName=blue
    colour_varValue=cyan
}

fprint()
{   # fancy print function
    # Usage: fprint "output string" [colout options]

    declare output="$1" regex="$2"; shift 2

    _inPath colout && {
        printf "%s\n" "$output" | colout "$regex" $*
    } || {
        printf "%s\n" "$output"
    }
}

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

whichalias()
{   # like `type [alias]`, but prettier
    declare name="$1" target

    target="$(alias "$name" 2>/dev/null |
        sed -E "s/(^.+=')|(\\\'')|('$)//g")" # strip and unescape single quotes

    [[ $target ]] || return 1

    fprint "$name is aliased to \`$target'" "(^$name).*\`(.+)'$" \
        $colour_aliasName,$colour_aliasValue normal
}

whichspecial()
{   # like `type [name]`, but prettier
    declare name="$1" desc
    declare thingType="$(type -t $name)"
    declare colour=$(eval "echo -n \$colour_$thingType")

    desc="$name is a shell $thingType"

    # so colout doesn't choke on `[[`
    printf -v name "%q" "$name"

    fprint "$desc" "(^$name) is a (.+)$" \
        $colour,$colour_specialDef normal
}

whichfile()
{   # like `type -p [file]`, but...
    declare name="$1" fileName
    declare -a fileNames=($(type -ap $name))

    [[ ${#fileNames[@]} -gt 0 ]] || return 1

    for fileName in ${fileNames[@]}; do
        fprint "$name is $fileName" "(^$name) is (.+)$" \
            $colour_fileName,$colour_filePath normal
    done
}

where()
{   # return filename and line number where function $1 was defined
    declare func="$1" location

    declare -f "$func" 1>/dev/null || {
        printf "%s: %s: function not found\n" $FUNCNAME $func 1>&2
        return 1
    }

    # enable debugging behaviour if not
    [[ $BASHOPTS =~ extdebug ]] || {
        declare extdebug=true
        shopt -s extdebug
    }

    # [name] [line] [file] -> [file]:[line]
    location="$(declare -F "$func" | sed -E "s/^$func ([[:digit:]]+) (.*)$/\2:\1/")"

    fprint "${location/#$HOME/~}" "(.+)(:)([0-9]+)" \
        $colour_functionFile,$colour_punct,$colour_functionLine normal

    # back to normal debugging behaviour
    [[ $extdebug ]] &&
        shopt -u extdebug
}

functionsrc()
{   # display location and source code of function $1
    declare func="$1"
    where "$func" || return 1

    # skip "$1 is a function" line and colourize source
    fprint "$(declare -f "$func" | tail -n+1)" -s bash
}

gethelp()
{   # return a short description of builtin command $1
    declare topic="$1" helpString

    helpString="$(help -d "$topic" 2>/dev/null)" ||
        return 1

    echo "${helpString#* - }"
}

synopsis()
{   # return a short description of system command $1
    declare thing="$1" line
    declare goodString="^$thing[^[:alnum:]]" failString='nothing appropriate$'

    whatis "$thing" | while read line; do
        # if not found in whatis database
        [[ $line =~ $failString ]] &&
            return 1

        # skip builtins and non-whole-word matches
        [[ $line =~ "built-in command" || ! $line =~ $goodString ]] &&
            continue

        # output e.g. "grep(1): blah blah blah..."
        echo "$line" |
            sed -E "s/^($thing)[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/\1\2: \3/g"
    done
}

typevar()
{   # like `type`, but for variables
    declare varName="$1" varFlags varNature
    declare varType="variable" varProperty varContent
    declare article="a" string nocaseSwitched

    [[ $BASHOPTS =~ nocasematch ]] && {
        # case-sensitive matching
        shopt -u nocasematch && nocaseSwitched=true
    }

    string=$(declare -p "$varName" 2>/dev/null) || {
        printf "%s: %s: not set\n" $FUNCNAME $varName 1>&2
        [[ $nocaseSwitched ]] && shopt -s nocasematch
        return 1
    }

    string="${string/#declare /}"
    varFlags="${string%% *}"
    varValue="${string#*=}"

    case $varFlags in
        *a*)    varType="indexed array"     ;;&
        *A*)    varType="associative array" ;;&
        *i*)    varContent="integer"   ;;&
        *r*)    varProperty+="${varProperty:+, }read-only" ;;&
        *t*)    varProperty+="${varProperty:+, }traced"    ;;&
        *x*)    varProperty+="${varProperty:+, }exported"  ;;&
        *l*)    varContent="lowercase" ;;&
        *u*)    varContent="uppercase" ;;&
        *)      true ;;
    esac

    varNature="${varProperty:+$varProperty }${varContent:+$varContent }${varType}"

    [[ ${varNature:0:1} =~ [aeiou] ]] && article+="n"

    echo "$varName is $article $varNature"

    [[ $nocaseSwitched ]] && shopt -s nocasematch
}

expand_array()
{   # does what it says on the tin
    declare arrayName="$1" arrayType arrayContents
    declare key keys value

    arrayType="$(typevar "$arrayName" 2>/dev/null)"

    [[ $arrayType =~ array$ ]] || {
        printf "%s: %s: not an array\n" $FUNCNAME $varName 1>&2
        return 1
    }

    for key in $(eval "echo -n \${!${arrayName}[@]}"); do
        eval "echo [$key]=\${${arrayName}[$key]}"
    done
}

whatvar()
{   # display the contents of a variable
    declare varName="$1" varType varValue

    varType="$(typevar "$varName" 2>/dev/null)" &&
       echo "$varType"

    case $varType in
        *variable)
            varValue="${!varName//\\e}"
            echo "$varValue"
            ;;
        *array)
            expand_array "$varName"
            ;;
        *)
            printf "%s: %s: not set\n" $FUNCNAME $varName 1>&2
            return 1
            ;;
    esac
}

# ------------------------------------------------------------------------------
# which(): a better version of `type`
# ------------------------------------------------------------------------------

which()
{   # return location/nature of $1
    declare thing="$1" thingType
    declare -a thingTypes=($(type -at $thing | uniq))

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
                whichspecial "$thing"
                ;;
            file)
                whichfile "$thing"
                ;;
        esac
    done
}

# -----------------------------------------------------------------------------
# what(): a brief synopsis of commands, programs and topics
# -----------------------------------------------------------------------------

what()
{   # Usage: what [topic]    -- first result
    #        what -a [topic] -- all results

    declare thing thingType helpString showAll
    declare -a thingTypes

    [[ $1 == "-a" ]] && {
        showAll=true
        shift
    }

    thing="$1"

    # is it in the whatis database?
    helpString="$(synopsis "$thing")"

    [[ $showAll ]] && {
        thingTypes=($(type -at $thing | uniq))
    } || {
        thingTypes=($(type -t "$thing"))
    }

    [[ ${#thingTypes[@]} -gt 0 ]] && {
        for thingType in ${thingTypes[@]}; do
            case "$thingType" in
                alias)
                    whichalias "$thing"
                    ;;
                function)
                    functionsrc "$thing"
                    ;;
                builtin|keyword)
                    helpString="$(gethelp "$thing")" &&
                        fprint "$thing ($thingType): $helpString" "^$thing" \
                            $colour_specialName normal
                    ;;
                file)
                    helpString="$(synopsis "$thing")" && {
                        fprint "$helpString" "^$thing" \
                            $colour_fileName normal
                    } || {
                        whichfile "$thing"
                    }
                    ;;
            esac
        done
    } || {
        # system libraries and non-command man pages
        [[ $helpString ]] && {
            fprint "$helpString" "^$thing" $colour_fileName normal
            return 0
        } || {
            # variables
            declare -p "$thing" &>/dev/null && {
                whatvar "$thing"
            } || {
                printf "%s: %s: not found\n" $FUNCNAME "$thing" 1>&2
                return 1
            }
        }
    }
}

# -----------------------------------------------------------------------------
# h(): context-sensitive help
# -----------------------------------------------------------------------------

h()
{
    declare thing="$1"
    declare thingType="$(type -t "$thing")"

    case "$thingType" in
        builtin|keyword)
            help -m "$thing" | $PAGER
            return 0
            ;;
        file)
            man "$thing" 2>/dev/null
            return 0
            ;;
    esac

    printf "$thing: help not found\n" 1>&2
    return 1
}

# -----------------------------------------------------------------------------
# other "helpful" functions
# -----------------------------------------------------------------------------

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
