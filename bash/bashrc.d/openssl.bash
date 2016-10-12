# OpenSSL

# wget http://curl.haxx.se/ca/cacert.pem -o "$HOME/etc/ssl/cacert.pem"
declare -a certificates=(
  "/usr/local/etc/openssl/cert.pem"
  "/etc/ssl/certs/ca-bundle.crt"
  "$HOME/etc/ssl/cacert.pem"
)

for certificate in "${certificates[@]}"; do
  if [[ -r $certificate ]]; then
    export CURL_CA_BUNDLE=$certificate
    break
  else
    unset -v CURL_CA_BUNDLE
  fi
done

unset -v certificate certificates
