function average --description 'Get the average colour of an image'
    magick $argv[1] -resize 1x1 txt:- | string match -rg "(#[[:xdigit:]]{6})"
end
