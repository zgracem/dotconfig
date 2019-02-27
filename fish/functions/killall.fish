function killall --wraps killall
  command killall -v $argv
end
