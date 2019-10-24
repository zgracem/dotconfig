function ss --wraps 'set --show' --description 'Display information about a shell variable'
  set --show $argv | string match -ev ": not set in " | head -n-1
end
