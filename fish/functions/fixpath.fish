function fixpath --description 'Removes duplicate and missing dirs from a PATH variable'
  set -l dir
  set -l out_PATH

  for dir in $argv
    switch "$out_PATH"
    case "*$dir*"
      :
    case '*'
      test -d "$dir"; and set -a out_PATH $dir
    end
  end

  echo -n "$out_PATH"
end
