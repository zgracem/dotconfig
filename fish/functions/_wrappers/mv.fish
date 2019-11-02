if is-macos
  function mv --description 'Move files'
    # http://brettterpstra.com/2014/07/04/how-to-lose-your-tags/
    /bin/mv -iv $argv
  end
else
  function mv --description 'Move files'
    command mv -iv $argv
  end
end
