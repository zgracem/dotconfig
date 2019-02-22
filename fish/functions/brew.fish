# Addresses https://github.com/Homebrew/brew/issues/5791
function brew
  if [ "$argv[1]" = "update" ]
  	env SHELL=(type -P bash) brew $argv
  else
    command brew $argv
  end
end
