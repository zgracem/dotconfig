def toregex:
    "^" + gsub("(?<char>[[\\].?{}+()])";"\\\(.char)");

def convert_time:
    . + " " + (now | strflocaltime("%z")) |
    strptime("%a %b %e %H:%M:%S %Y %z") |
    strflocaltime("%F %T %z") |
    sub("(?<z>[+-]\\d{2})(?=00$)"; "\(.z):");

. as $data |
.name + "/" | toregex as $dir |
$data |
.time |= convert_time |
.date_added |= convert_time |
.date_started |= convert_time |
.files |= map(.file_name |= gsub($dir; ""))
