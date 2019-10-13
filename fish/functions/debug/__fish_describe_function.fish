function __fish_describe_function -d 'Return a function\'s description, if any'
  set -l details (functions --details --verbose $argv[1])
  if string match -eq 'n/a' "$details[5]"
    return 1
  else
    echo $details[5]
  end
end
