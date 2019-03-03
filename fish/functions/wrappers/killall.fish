function killall --wraps killall --description 'Kill processes by name'
  command killall -v $argv
end
