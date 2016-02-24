z::cbase()
{
    if (( $# == 1 )); then
        local from=${FUNCNAME[1]%2*}
        local to=${FUNCNAME[1]#*2}
        local n=$1
        
        n=${n#0}    # remove leading 0 from octal/hex input
        n=${n#[xX]} # remove leading x from hex input
    else
        scold "${FUNCNAME[1]}: syntax error"
        return 1
    fi

    local nbase
    case $from in
        bin) nbase=2  ;;
        oct) nbase=8  ;;
        dec) nbase=10 ;;
        hex) nbase=16 ;;
    esac

    local i
    i=$(( $nbase#$n )) || return

    case $to in
        bin) bc -q <<< "obase=2;ibase=$nbase;${n^^}" ;;
        oct) printf "%#o\n" "$i" ;;        # └─ bc(1) needs uppercase hex
        dec) printf "%d\n"  "$i" ;;
        hex) printf "%#x\n" "$i" ;;
    esac
}

dec2hex() { z::cbase "$@"; }
oct2hex() { z::cbase "$@"; }
dec2oct() { z::cbase "$@"; }
hex2oct() { z::cbase "$@"; }
hex2dec() { z::cbase "$@"; }
oct2dec() { z::cbase "$@"; }
bin2dec() { z::cbase "$@"; }
bin2hex() { z::cbase "$@"; }
bin2oct() { z::cbase "$@"; }
dec2bin() { z::cbase "$@"; }
hex2bin() { z::cbase "$@"; }
oct2bin() { z::cbase "$@"; }

## testing
# dec2bin 15
# hex2bin F
# oct2bin 17
# bin2hex 1000100010001
# dec2hex 4369
# oct2hex 10421
# bin2oct 1001001001
# dec2oct 585
# hex2oct 0x249
# bin2dec 10001010111
# hex2dec 0X457
# oct2dec 2127
