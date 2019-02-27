function rm --wraps rm
  if is-gnu rm
    command rm -Iv $argv
  else
    command rm -iv $argv
  end
end
