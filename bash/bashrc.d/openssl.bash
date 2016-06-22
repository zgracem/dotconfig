# OpenSSL
return
### ZGM disabled 2016-06-21 -- this gives me certificate errors :/ :/ :/


# wget http://curl.haxx.se/ca/cacert.pem -o "$HOME/etc/ssl/cacert.pem"
declare -a certificates=(
  "$HOME/etc/ssl/cacert.pem"
  "/etc/ssl/certs/ca-bundle.crt"
  "/usr/local/etc/openssl/cert.pem"
  "/usr/local/etc/openssl/certs/ca-bundle.crt"
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
