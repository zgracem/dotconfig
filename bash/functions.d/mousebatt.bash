[[ $OSTYPE =~ darwin ]] || return

mousebatt()
{   # print status of Bluetooth mouse battery
    ioreg -d 7 -n BNBMouseDevice \
    | sed -nE 's/^.*\"BatteryPercent\" = ([[:digit:]]+)$/\1%/p'
}
