function g --wraps grep --description 'Search files in PWD'
  grep --line-number $argv -- ./*
end
