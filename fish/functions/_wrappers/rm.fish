if is-gnu rm
  function rm --description 'Remove directory entries'
    command rm -Iv $argv
  end
else
  function rm --description 'Remove directory entries'
    command rm -iv $argv
  end
end
