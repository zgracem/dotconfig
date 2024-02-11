function shove --description 'Touch a file, creating all necessary directories'
    for path in $argv
        mkdir -pv (dirname $path)
        and touch $path
    end
end
