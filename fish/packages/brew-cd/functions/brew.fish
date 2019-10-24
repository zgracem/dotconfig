function brew --description 'The missing package manager for macOS'
  in-path brew; or return 127

  switch $argv[1]
  case 'update'
    # Addresses https://github.com/Homebrew/brew/issues/5791
    env SHELL=(type -P bash) brew $argv
  case 'cd'
    _brew_cd $argv[2..-1]
  case '*'
    command brew $argv
  end
end
