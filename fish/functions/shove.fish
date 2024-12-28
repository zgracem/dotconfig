function shove --description 'Touch a file, creating all necessary directories'
    mkdir -pv (dirname $argv)
    and touch $argv
end
