function dataurl --description 'Convert an image to a data: URL' -a image
  if not test -f "$image"
    echo >&2 "file not found:" $image
    return 1
  end

  set -l ext (string split . "$image")[-1]
  set -l b64 (openssl base64 -in "$image" | tr -d '\n'); or return

  printf 'data:image/%s;base64,%s\n' "$ext" "$b64"
end
