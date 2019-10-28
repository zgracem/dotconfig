function fish_version -d 'Display information about the current fish version'
  set -l info (string split "." "$version" | string split "-")

  switch "$argv[1]"
  case major
    echo $info[1]
  case minor
    echo $info[2]
  case patch
    echo $info[3]
  case revision
    if set -q info[4]
      echo $info[4]
    else
      return 1
    end
  case commit
    if set -q info[5]
      string sub -s2 $info[5]
    else
      return 1
    end
  case state
    if set -q info[6]
      echo $info[6]
    else
      echo "release"
    end
  case '*'
    echo $version
  end
end
