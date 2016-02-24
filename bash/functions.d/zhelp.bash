zk=${esc_black:-$'\e[0;30m'}
zr=${esc_red:-$'\e[0;31m'}
zg=${esc_green:-$'\e[0;32m'}
zy=${esc_yellow:-$'\e[0;33m'}
zb=${esc_blue:-$'\e[0;34m'}
zm=${esc_magenta:-$'\e[0;35m'}
zc=${esc_cyan:-$'\e[0;36m'}
zw=${esc_white:-$'\e[0;37m'}
z0=${esc_reset:-$'\e[0m'}

case $Z_SOLARIZED in
    light)
        z_no=${esc_false:-$'\e[1;31m'}
        z_hi=$zk
        ;;
    *)
        z_no=$zr
        z_hi=$zw
        ;;
esac

z::print()
{   # echo to standard output

    if [[ -t 1 ]]; then
        printf "${z0}%b${z0}" "$@"
    else
        # strip colours before printing
        printf '%b' "$@" \
        | sed -E 's|\[[0-9;]*m?||g'
    fi
}

where()
{
    if (( $# > 0 )); then
        local func="$1"
    else
        return 1
    fi

    # enable advanced debugging behaviour
    shopt -q extdebug || trap 'shopt -u extdebug; trap - RETURN;' RETURN
    shopt -s extdebug

    local location line

    if ! declare -f "$func" &>/dev/null; then
        z::print "${z_no}${func}${z0}: not a function\n" >&2
        return 1
    else
        location=$(declare -F "$func")  # prints "[name] [line#] [/path/to/file]"
        location=${location#$func }     # remove function name
        line=${location%% *}            # isolate line number
        location=${location#$line }     # remove line number
        
        if [[ -t 1 ]]; then
            # tilde-ify homedir unless we're piping this somewhere
            location=${location/#$HOME/$'~'}
        fi
    fi

    if [[ $location == '(null)' ]]; then
        z::print "${z_no}${func}${z0}: could not determine source file\n" >&2
        return 1
    elif [[ -n $location && -n $line ]]; then
        z::print "${zg}${location}${z_hi}:${zy}${line}"

        if [[ ${FUNCNAME[2]} != which ]]; then
            z::print '\n'
        fi
    fi
}

z::whatis()
{
    # disable case-insensitive matching
    shopt -q nocasematch && trap 'shopt -s nocasematch; trap - RETURN;' RETURN
    shopt -u nocasematch

    local thing="$1"

    local regex_fail='nothing appropriate$'
    local regex_pass="^${thing}[[:space:](]"
    local regex_trouble='[]\[()]'

    # escape characters that sed won't like
    if [[ $thing =~ $regex_trouble ]]; then
        printf -v thing '%q' "$thing"
    fi

    # check whatis database
    local line; while read line; do
        if [[ $line =~ $regex_fail ]]; then
            return 1 # not found at all in whatis database, abort
        elif [[ ! $line =~ $regex_pass ]]; then
            continue # skip non-whole-word matches
        elif [[ $line =~ 'built-in command' ]]; then
            continue # skip builtins
        else
            sed -E \
                -e "s/^(${thing})[^\(]*(\([[:alnum:]]+\))[[:space:]-]+(.*)/${zy}\1${z0}\2: \3/g" \
                -e "s/[[:space:]]+-[[:space:]]/: /" \
            <<< "$line"
        fi
    done < <(command whatis "$thing" 2>&1)

    return 1
}

z::help()
{
    local thing="$1" desc

    if desc=$(builtin help -d "$thing" 2>/dev/null); then
        z::print "${zm}${thing}${z0}${thing_type:+ ($thing_type)}: ${desc#* - }\n"
    else
        return 1
    fi
}

z::wtf()
{
    local this=${FUNCNAME[1]:-${FUNCNAME[0]}}

    if (( $# == 1 )); then
        local thing="$1"
        local -a thing_types=($(builtin type -at "$thing" | uniq))
    else
        z::print "${z_no}${this}${z0}: syntax error\n" >&2
        return 1
    fi

    # disable case-sensitive matching
    shopt -q nocasematch && trap 'shopt -s nocasematch; trap - RETURN;' RETURN
    shopt -u nocasematch

    if (( ${#thing_types[@]} > 0 )); then
        local thing_type def place
        for thing_type in "${thing_types[@]}"; do
            case $thing_type in
                file)
                    [[ $this == what ]] && z::whatis "$thing"
                    local -a places=($(builtin type -ap "$thing"))
                    for place in "${places[@]}"; do
                        def="${zg}${place}\n"

                        if [[ -t 1 ]]; then
                            z::print "${zy}${thing}${z0} is ${zg}${place}\n"
                        else
                            z::print "${place}"
                            break
                        fi
                    done
                    ;;
                alias)
                    def="${zy}$(builtin type "$thing")"
                    def="${def/ /$z0 }"
                    def="${def/\`/‘$zc}"
                    def="${def/\'/$z0}’"
                    
                    z::print "${def}\n"
                    ;;
                keyword|builtin)
                    if [[ $this == which ]] || ! def=$(help -d "$thing" 2>/dev/null); then
                        z::print "${zm}${thing}${z0} is a shell ${thing_type}\n"
                    else
                        z::print "${zm}${thing}${z0} (${thing_type}): ${def#* - }\n"
                    fi
                    ;;
                function)
                    if [[ $this == which ]]; then
                        if [[ -t 1 ]]; then
                            z::print "${zb}${thing}${z0} is a ${zb}function${z0} ("
                            where "$thing"
                            z::print ')\n'
                        else
                            where "$thing"
                        fi
                    elif [[ -t 1 ]]; then
                        where "$thing"
                        declare -f "$thing" \
                        | sed -E "s/^${thing}\b/${zb}\0${z0}/"
                    else
                        where "$thing"
                        declare -f "$thing"
                    fi
                    ;;
                *)
                    return 1
                    ;;
            esac
            [[ $this == which ]] && break
        done

        return 0
    elif [[ $this == what ]]; then
        # system libraries & other non-command man pages
        z::whatis "$thing" \
            && return 0

        # edge-case shell syntax items
        z::help "$thing" \
            && return 0
    fi

    z::print "${z_no}${thing}${z0}: not a thing\n" >&2
    return 1
}

quietly unalias which

which() { z::wtf "$@"; }
what() { z::wtf "$@"; }

# -----------------------------------------------------------------------------
# variables
# -----------------------------------------------------------------------------

(( BASH_VERSINFO[0] < 4 )) && return

whatvar()
{
    local this=${FUNCNAME[1]:-${FUNCNAME[0]}}

    if (( $# == 1 )); then
        local var="$1"
    else
        z::print "${z_no}${this}${z0}: syntax error\n" >&2
        return 1
    fi

    # disable case-sensitive matching
    shopt -q nocasematch && trap 'shopt -s nocasematch; trap - RETURN;' RETURN
    shopt -u nocasematch

    local string
    if ! string=$(declare -p "$var" 2>/dev/null); then
        z::print "${z_no}${var}${z0}: not set\n" >&2
        return 1
    fi

    string="${string#declare }"
    local flags="${string%% *}"
    local value="${string#*=}"
    local var_type='variable' var_cont var_prop

    case $flags in
        *a*)    var_type='indexed array'
                ;;&
        *A*)    var_type='associative array'
                ;;&
        *i*)    var_cont='integer'
                ;;&
        *r*)    var_prop+="${var_prop:+, }read-only"
                ;;&
        *t*)    var_prop+="${var_prop:+, }traced"
                ;;&
        *x*)    var_prop+="${var_prop:+, }exported"
                ;;&
        *l*)    var_cont='lowercase'
                ;;&
        *u*)    var_cont='uppercase'
                ;;&
        *)      : ;;
    esac

    # concatenate with single spaces
    read nature <<< "$var_prop $var_cont $var_type"

    if [[ $value == '""' ]]; then
        nature="null ${nature}"
    elif [[ $value == "'()'" ]]; then
        nature="empty ${nature}"
    fi

    if [[ ${nature:0:1} =~ [aeiou] ]]; then
        local article='an'
    else
        local article='a'
    fi

    z::print "${zc}${var}${z0} is ${article} ${nature}\n"

    case $nature in
        *null*|*empty*)
            : ;;
        *variable)
            printf '%s\n' "${!var//\\e}"
            ;;
        *array)
            explode "$var"
            ;;
    esac

    return 0
}
