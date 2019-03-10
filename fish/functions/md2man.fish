function md2man -a markdown_file --description 'Quickly view a ronn-formatted man page'
  in-path ronn; or begin; echo >&2 "error: not found: ronn"; return 127; end
  man (ronn --pipe --roff $markdown_file | psub)
end
