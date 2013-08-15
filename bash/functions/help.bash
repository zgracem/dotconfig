# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------
# colour -- requires colout: https://github.com/nojhan/colout
# ------------------------------------------------------------------------------

_inPath colout && {
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
{   # like `type -p [file]`, but... you get the idea
    declare name="$1" fileName
    declare -a fileNames=($(type -ap $name))

    [[ ${#fileNames[@]} -gt 0 ]] || return 1

    for fileName in ${fileNames[@]}; do
        fprint "$name is $fileName" "(^$name) is (.+)$" \
            $colour_fileName,$colour_filePath normal
    done
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
        [[ $line =~ "bash built-in command" || ! $line =~ $goodString ]] &&
            continue

        # output e.g. "grep(1): blah blah blah..."
        echo "$line" |
            sed -E "s/^($thing)[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/\1\2: \3/g"
    done
}

where()
{   # return filename and line number where function $1 was defined
    declare func="$1"

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
    declare -F "$func" | sed -E "s/^$func ([[:digit:]]+) (.*)$/\2:\1/"

    # back to normal debugging behaviour
    [[ $extdebug ]] &&
        shopt -u extdebug
}

functionsrc()
{   # return location and source code of function $1
    declare func="$1" location
    location="$(where "$func")" || return 1

    fprint "${location/#$HOME/~}" "(.+):([0-9]+)" \
        $colour_functionFile,$colour_functionLine normal

    # skip "$1 is a function" line and colourize source
    fprint "$(declare -f "$func" | tail -n+1)" -s bash
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
            printf "%s: %s: not found\n" $FUNCNAME "$thing" 1>&2
            return 1
        }
    }
}

# -----------------------------------------------------------------------------
# other "helpful" functions
# -----------------------------------------------------------------------------

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
