explode()
{   # expands and displays an array
    local array="$1" cmd key

    cmd="$(declare -p $array 2>&1)"

    case $cmd in
        declare\ -[aA]*)
            # transfer $1 to our own array
            eval "${cmd/$array/array}"

            for key in ${!array[*]}; do
                echo "[$key]=${array[$key]}"
            done

            return 0
            ;;
        declare*)
            scold "$FUNCNAME: $array: not an array"
            ;;
        *not\ found)
            scold "$FUNCNAME: $array: not found"
            ;;
    esac

    return 1
}
