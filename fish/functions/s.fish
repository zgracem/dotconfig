function s --description 'Add file(s) or dir(s) to Sublime Text'
  set -l target
  if test (count $argv) -eq 0
    set target "$PWD"
  else
    set target $argv
  end

  subl --add $target
end
