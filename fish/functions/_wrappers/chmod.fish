function chmod --description 'Change the mode of files'
  if is-gnu chmod
    command chmod --changes $argv
  else
    command chmod -v $argv
  end
end
