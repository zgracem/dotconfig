function _brew_cd
  switch $argv[1]
  case 'cache' 'cellar' 'prefix' 'repo' 'repository'
    cd (command brew --$argv[1] $argv[2..-1])
  case '*'
    printf >&2 "%s: destination unknown\\n" "$destination"
    return 1
  end
end
