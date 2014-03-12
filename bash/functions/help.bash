# ------------------------------------------------------------------------------
# ~zozo/.config/bash/functions/help.bash
# ------------------------------------------------------------------------------

case $solarized in
    light)  colour_punct=base02 ;;
    *)      colour_punct=base2 ;;
esac

colour_aliasName=yellow
colour_aliasValue=cyan

colour_functionName=blue
colour_functionFile=green
colour_functionLine=yellow

colour_specialName=magenta
colour_specialDef=null
colour_builtin=$colour_specialName
colour_keyword=$colour_specialName

colour_fileName=yellow
colour_filePath=green

colour_varName=blue
colour_varValue=null

cprint()
{   # print in colour!

    # require an even number of arguments
    [[ $(( $# % 2 )) -eq 0 ]] || {
        scold "Usage: $FUNCNAME colour string [colour string] [...]"
        return 1
    }

    declare regex='^\[[[:digit:];]+m$'
    declare colour string

    until [[ $# -eq 0 ]]; do
        colour="${!1}" string="$2"

        # only print colour to stdout
        [[ -t 1 ]] && {
            [[ $colour =~ $regex ]] || {
                scold "$FUNCNAME" "invalid ANSI colour sequence: $colour"
                return 1
            }

            printf "%b%b%b" "${colour}" "$string" "[0m"
        } || {
            printf "%b" "$string"
        }

        shift 2
    done

    printf "%b" "\n"
}

# -----------------------------------------------------------------------------
# support functions
# -----------------------------------------------------------------------------

fancy_help()
{   # return a short description of $1 (via `help`)
    declare thing="$1" thingType

    thingType=$(type -t "$thing") || return 1

    case $thingType in
        builtin|keyword)
            help -d "$thing" 2>/dev/null |
            sed -E "s/^($thing) - /\1 ($thingType): /g"
            ;;
        *)
            return 1
            ;;
    esac
}

fancy_whatis()
{   # return a short description of $1 (via the whatis database)

    declare thing="$1" thingType
    declare regexPass="^$thing[[:space:](]"
    declare regexFail='nothing appropriate$'

    # check whatis database
    whatis "$thing" | while read line; do
        # if not found in whatis database
        [[ $line =~ $regexFail ]] &&
            return 1

        # skip non-whole-word matches
        [[ ! $line =~ $regexPass ]] &&
            continue

        # for builtins
        [[ $line =~ "built-in command" ]] && {
            # fancy_help "$thing"
            continue
        }

        # output e.g. "grep(1): blah blah blah..."
        echo "$line" |
            sed -E "s/^($thing)[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/\1\2: \3/g"

        found=true
    done

    [[ $found ]] && return 0
}

synopsis()
{   # return a short description of $1 if available
    fancy_whatis "$1" ||
    fancy_help "$1" ||
    return 1
}

# aliases

whichalias()
{   # like `type [alias]`, but prettier
    declare name="$1" target

    target="$(alias "$name" 2>/dev/null |
        sed -E "s/(^.+=')|(\\\'')|('$)//g")" # strip and unescape single quotes

    [[ $target ]] || return 1

    # fprint "$name is aliased to \`$target'" "(^$name).*\`(.+)'$" \
    #     $colour_aliasName,$colour_aliasValue normal

    cprint \
        $colour_aliasName "$name" \
        null " is aliased to \`" \
        $colour_aliasValue "$target" \
        null '"'
}

# shell builtins and keywords

whichspecial()
{   # like `type [name]`, but prettier
    declare name="$1" desc
    declare thingType="$(type -t $name)"
    #declare colour=$(eval "echo -n \$colour_$thingType")

    desc="$name is a shell $thingType"

    # so colout doesn't choke on `[[`
    printf -v name "%q" "$name"

    # fprint "$desc" "(^$name) is a (.+)$" \
    #     $colour_specialName,$colour_specialDef normal

    cprint \
        $colour_specialName "$name" \
        null " is a shell " \
        $colour_specialDef "$thingType"
}

# files

whichfile()
{   # like `type -p [file]`, but...
    declare name="$1" fileName
    declare -a fileNames=($(type -ap $name))

    [[ ${#fileNames[@]} -gt 0 ]] || return 1

    for fileName in ${fileNames[@]}; do
        # fprint "$name is $fileName" "(^$name) is (.+)$" \
        #     $colour_fileName,$colour_filePath normal

        cprint \
            $colour_fileName "$name" \
            null " is " \
            $colour_filePath "$fileName"
    done
}

# functions

where()
{   # return filename and line number where function $1 was defined
    declare func="$1" location

    declare -f "$func" 1>/dev/null || {
        scold "$FUNCNAME" "$func: function not found"
        return 1
    }

    # enable debugging behaviour if not
    _shoptSet extdebug || {
        declare extdebug=true
        shopt -s extdebug
    }

    # [name] [line] [file] -> [file]:[line]
    location="$(declare -F "$func" | sed -E "s/^$func ([[:digit:]]+) (.*)$/\2:\1/")"

    # fprint "${location/#$HOME/~}" "(.+)(:)([0-9]+)" \
    #     $colour_functionFile,$colour_punct,$colour_functionLine normal

    cprint \
        $colour_functionFile "${location%:*}" \
        $colour_punct ":" \
        $colour_functionLine "${location#*:}"

    # back to normal debugging behaviour
    [[ $extdebug ]] &&
        shopt -u extdebug
}

functionsrc()
{   # display location and source code of function $1
    declare func="$1"
    where "$func" || return 1

    # skip "$1 is a function" line and colourize source
    _inPath colout && {
        declare -f "$func" | tail -n+1 | colout -s bash
    } || {
        declare -f "$func" | tail -n+1
    }
}

# variables

typevar()
{   # like `type`, but for variables
    declare varName="$1"
    declare article="a" varType="variable"
    declare varFlags varNature varProperty varContent string

    _shoptSet nocasematch && {
        # case-sensitive matching
        shopt -u nocasematch && declare nocaseSwitched=true
    }

    string=$(declare -p "$varName" 2>/dev/null) || {
        scold "$FUNCNAME" "$varName: not set"
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

    cprint \
        $colour_varName "$varName" \
        null " is $article " \
        $colour_varValue "$varNature"

    [[ $nocaseSwitched ]] && shopt -s nocasematch
}

expand_array()
{   # does what it says on the tin
    declare arrayName="$1" arrayType arrayContents
    declare key keys value

    arrayType="$(typevar "$arrayName" 2>/dev/null)"

    [[ $arrayType =~ array$ ]] || {
        scold "$FUNCNAME" "$arrayName: not an array"
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
       typevar "$varName"

    case $varType in
        *variable)
            varValue="${!varName//\\e}"
            echo "$varValue"
            ;;
        *array)
            expand_array "$varName"
            ;;
        *)
            scold "$FUNCNAME" "$varName: not set"
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
        scold "$FUNCNAME" "$thing: not found"
        return 1
    }

    for thingType in ${thingTypes[@]}; do
        case "$thingType" in
            alias)
                whichalias "$thing"
                ;;
            function)
                # fprint "$thing is a function" "^$thing" \
                #     $colour_functionName normal

                cprint \
                    $colour_functionName "$thing" \
                    null " is a function"
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
# what(): a brief synopsis of commands, programs, topics and variables
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
                    helpString=$(fancy_help "$thing")

                    # fprint "$helpString" "^$thing" \
                    #     $colour_specialName normal

                    cprint \
                        $colour_specialName "$thing" \
                        null " ($thingType): ${helpString#*: }"
                    ;;
                file)
                    helpString=$(fancy_whatis "$thing")

                    [[ $helpString ]] && {
                        # fprint "$helpString" "^$thing" \
                        #     $colour_fileName normal

                        cprint \
                            $colour_fileName "$thing" \
                            null "${helpString:${#thing}}"
                    } || {
                        whichfile "$thing"
                    }
                    ;;
            esac
        done
    } || {
        # system libraries & other non-command man pages
        helpString="$(synopsis "$thing")" && {
            # fprint "$helpString" "^$thing" $colour_fileName normal

            cprint \
                $colour_fileName "$thing" \
                null "${helpString:${#thing}}"

            return 0
        } || {
            # variables
            declare -p "$thing" &>/dev/null && {
                whatvar "$thing"
            } || {
                scold "$FUNCNAME" "$thing: not found"
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
    declare thing="$1" thingType
    declare -a thingTypes=($(type -at $thing | uniq))

    for thingType in ${thingTypes[@]}; do
        case "$thingType" in
            builtin|keyword)
                help -m "$thing" | $PAGER
                return 0
                ;;
            file)
                man "$thing" 2>/dev/null ||
                    "$thing" --help 2>/dev/null || break
                return 0
                ;;
            *)
                continue
                ;;
        esac
    done

    scold "$thing" "help not found"
    return 1
}

# -----------------------------------------------------------------------------
# other "helpful" functions
# -----------------------------------------------------------------------------

vimhelp()
{   # load vim's inline help for topic $1
    command vim -c "help $1" -c only
}
