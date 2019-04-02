function strip_ansi --description 'Strips ANSI formatting escape codes from stdin'
  sed -E "s/\x1b\\[[0-9]+(;[0-9]+)*m//g" -
end
