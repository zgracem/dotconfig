function brew
  in-path brew; or return 127

  switch $argv[1]
  case 'update'
    # Addresses https://github.com/Homebrew/brew/issues/5791
    env SHELL=(type -P bash) brew $argv
  case 'cd'
    __brew_cd $argv[2..-1]
  case '*'
    command brew $argv
  end
end

function __brew_cd
  switch $argv[1]
  case 'cache' 'cellar' 'prefix' 'repo' 'repository'
    cd (command brew --$argv[1] $argv[2..-1])
  case '*'
    printf >&2 "%s: destination unknown\\n" "$destination"
    return 1
  end
end
