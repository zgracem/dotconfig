function md2html --description 'Convert Markdown to HTML' -a file
  # This function uses MultiMarkdown to convert a Markdown file to an HTML
  # snippet, then uses a Ruby gem <github.com/threedaymonk/htmlentities> to
  # decode HTML entities like "&#8230;" to Unicode chars like "…".
  multimarkdown -s $file \
  | ruby -rhtmlentities -e 'puts HTMLEntities.new.decode(ARGF.read)'
end
