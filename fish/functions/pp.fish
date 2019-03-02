function pp -a file --description 'Pretty-print fish source code'
  fish_indent --ansi < $file | less --quit-if-one-screen
end
