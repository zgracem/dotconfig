# -----------------------------------------------------------------------------
# solarized -- http://ethanschoonover.com/solarized
# -----------------------------------------------------------------------------
# SOLARIZED    HEX        RGB            TERMCOL     TERM    DARK   LITE
# -----------------------------------------------------------------------------
# base03       #002b36      0  43  54    brblack     01;30   bg     
# base02       #073642      7  54  66    black       30      hi     
# base01       #586e75     88 110 117    brgreen     01;32   2d     em
# base00       #657b83    101 123 131    bryellow    01;33          fg
#                                                                   
# base0        #839496    131 148 150    brblue      01;34   fg     
# base1        #93a1a1    147 161 161    brcyan      01;36   em     2d
# base2        #eee8d5    238 232 213    white       37             hi
# base3        #fdf6e3    253 246 227    brwhite     01;37          bg
#                                                                   
# yellow       #b58900    181 137   0    yellow      33             
# orange       #cb4b16    203  75  22    brred       01;31          
# red          #dc322f    220  50  47    red         31             
# magenta      #d33682    211  54 130    magenta     35             
# violet       #6c71c4    108 113 196    brmagenta   01;35          
# blue         #268bd2     38 139 210    blue        34             
# cyan         #2aa198     42 161 152    cyan        36             
# green        #859900    133 153   0    green       32             
# -----------------------------------------------------------------------------

solarized()
{   # toggle Solarized settings

    if [[ $1 =~ (light|dark) ]]; then
        Z_SOLARIZED="${BASH_REMATCH[1]}"
    else
        case $Z_SOLARIZED in
            dark)   Z_SOLARIZED=light ;;
            light)  Z_SOLARIZED=dark  ;;
            *)      Z_SOLARIZED=dark ;;
        esac
    fi

    export Z_SOLARIZED
    declare -p Z_SOLARIZED

    rl prompt
}
