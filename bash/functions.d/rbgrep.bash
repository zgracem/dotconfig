rbgrep()
{ #: -- searches Ruby source files
  grep -nR --exclude-dir='doc' "$@" \
    ~/{scripts,src/ruby,Dropbox/www/vs2017/lib}/**/*.rb
}
