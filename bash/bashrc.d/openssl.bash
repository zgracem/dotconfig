# OpenSSL

declare -a certificates=(
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
