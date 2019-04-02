function md2html --description 'Convert Markdown to HTML with simple smart quotes' -a file
  multimarkdown -s $file \
    | string replace -a '&#8211;' '–' | string replace -a '&#8212;' '—' \
    | string replace -a '&#8216;' '‘' | string replace -a '&#8217;' '’' \
    | string replace -a '&#8220;' '“' | string replace -a '&#8221;' '”' \
    | string replace -a '&#8230;' '…'
end
