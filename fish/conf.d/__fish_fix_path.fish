function __fish_fix_path -a var --description 'Remove duplicate and missing dirs from a path variable'
  set -l ORIGINAL_PATH $$var
  set -l FIXED_PATH

  for dir in $ORIGINAL_PATH
    if contains -- $dir $FIXED_PATH
      continue
    else if test -d "$dir"
      set FIXED_PATH $FIXED_PATH $dir
    end
  end

  if not string upper -q "$var"
    set -g $var "$FIXED_PATH"
  else
    set -g $var $FIXED_PATH
  end
end
