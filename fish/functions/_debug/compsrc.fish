function compsrc -d 'Display completion source file(s)' -a query
  for file in $fish_complete_path/$query.fish;
    test -f "$file"; and short_home "$file"
  end
end
