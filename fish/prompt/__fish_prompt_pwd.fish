function __fish_prompt_pwd --description 'Format the current directory for the prompt'
  set -l max (math --scale 0 "$COLUMNS / 4") # maximum length = 1/4rd window width

  set -l short_path (pwd | string replace -r ".*/" "")   # basename of current dir
  set -l short_path_length (string length $short_path)

  # if basename of $PWD is too long by itself, don't trim it
  if test $max -lt $short_path_length
    set max $short_path_length
  end

  # tilde-ify homedir
  set -l long_path (pwd | string replace -r "^$HOME" "~")

  # is $PWD too long, and if so, by how much?
  set -l long_path_length (string length $long_path)
  set -l excess (math --scale 0 "$long_path_length - $max")

  if test $excess -gt 0
    # cut to $max chars long, trim leading detritus and add leader
    set cut_path (string sub --start $excess $long_path)
    set path_parts (string split --max=1 / $cut_path)
    set trimmed_path $path_parts[2]

    set long_path "…/$trimmed_path"
  end

  set_color $fish_color_cwd
  echo -n $long_path
end
