function __fish_path_fixer --description 'Removes duplicate and missing dirs from a PATH variable'
  set -l dir
  set -l ORIGINAL_PATH $argv
  set -l FIXED_PATH

  for dir in $ORIGINAL_PATH
    if contains -- $dir $FIXED_PATH
      continue
    else
      test -d "$dir"; and set FIXED_PATH $FIXED_PATH $dir
    end
  end

  echo -n "$FIXED_PATH"
end
