function gg --wraps grep --description 'Search files and directories in PWD'
  grep --line-number --recursive $argv -- ./*
end
