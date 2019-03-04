function md2man -a markdown_file --description 'Quickly view a ronn-formatted man page'
  in-path ronn; or return 127
  man (ronn --pipe --roff $markdown_file | psub)
end
