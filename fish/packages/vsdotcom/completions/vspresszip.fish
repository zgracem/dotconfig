function __fish_complete_vsdotcom_slugs
  set -l file $HOME/Dropbox/www/vs2017/data/projects.yaml
  string match -r '(?<=").+(?=":)' < "$file" | sort -u
end

complete -c vspresszip -xa "(__fish_complete_vsdotcom_slugs)"
