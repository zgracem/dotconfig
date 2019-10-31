function shove --description 'Touch a file, creating all necessary directories'
  for path in $argv
    mkdir -p (dirname $path)
    and touch $path
  end
end
