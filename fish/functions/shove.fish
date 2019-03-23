function shove --description 'Touch a file, creating all necessary directories'
  for arg in $argv
    mkdir -p (dirname $arg); and touch $arg
  end
end
