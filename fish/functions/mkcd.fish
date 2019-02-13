function mkcd --description 'Create a directory, then move into it'
  command mkdir -p $argv[1]
  and cd $argv[1]
end
