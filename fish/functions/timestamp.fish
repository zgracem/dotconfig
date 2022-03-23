function timestamp -d "Print a hexadecimal timestamp"
    # output epoch seconds (plus nanoseconds) as hexadecimal
    printf "%016x" (gdate +%s%N | string trim -r -c0)
end
