function local_ruby_versions --description "List all .ruby-version files and their values"
  if not in-path fd
    echo >&2 "fatal error: this command requires `fd`"
    return 127
  end

  set --local dirs ~/Dropbox ~/www
  set --local rv_files (fd -tf -d5 -sHFa ".ruby-version" $dirs)

  for rv_file in $rv_files
    set --local rb_version (cat $rv_file)
    printf "[%s] %s\n" $rb_version $rv_file
  end \
  | sort -u
end
