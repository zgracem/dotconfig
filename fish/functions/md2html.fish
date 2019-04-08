function md2html --description 'Convert Markdown to HTML with simple smart quotes' -a file
  multimarkdown -s $file | sed \
    -e 's/&#8211;/–/g' -e 's/&#8212;/—/g' \
    -e 's/&#8216;/‘/g' -e 's/&#8217;/’/g' \
    -e 's/&#8220;/“/g' -e 's/&#8221;/”/g'
    -e 's/&#8230;/…/g'
end
