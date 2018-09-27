csv()
{ #: - preview CSV files from the command line
  #: > http://stackoverflow.com/questions/1875305/command-line-csv-viewer
  sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}
