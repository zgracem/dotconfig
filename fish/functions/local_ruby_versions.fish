function local_ruby_versions --description "List all .ruby-version files and their values"
  for req in fd rbenv
    if not in-path $req
      echo >&2 "fatal error: this command requires `$req`"
      return 127
    end
  end

  set --local dirs ~/Dropbox ~/www
  set --local rv_files (fd -tf -sHFa ".ruby-version" $dirs)
  set --local rb_versions (rbenv versions --bare)

  for rv_file in $rv_files
    set --local rb_version (cat $rv_file)

    printf "%s/%s\n" $rb_version (dirname $rv_file | string replace "$HOME" "~")
  end \
  | sort -u \
  | while read line
    set --local info (string split --max=1 "/" $line)
    set --local rb_version $info[1]
    set --local rv_file $info[2]

    if not contains $rb_version $rb_versions
      # highlight uninstalled versions
      set rb_version (set_color brred)$rb_version(set_color normal)
    end

    printf "[%s] %s\n" $rb_version $rv_file
  end
end
