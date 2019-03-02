function __man_title
  set -l manfile (command man -w $argv)
  or return $status

  set -l match (string match -r '.*/(.+?)\.(.+?)(?:\.gz)?' "$manfile")
  or return $status

  set -l title $match[2]
  set -l section $match[3]

  echo "$title($section)"
end
