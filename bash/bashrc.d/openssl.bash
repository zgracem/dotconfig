# OpenSSL

### ZGM disabled 2017-01-09
#   DO NOT RESTORE without documenting why it's needed, what breaks w/out it,
#   and how to make it work w/out fucking up e.g. Homebrew downloads and
#   Pushover API calls. Make sure you test on Erato, Hiroko and WebFaction and
#   not just Athena.
return

# wget http://curl.haxx.se/ca/cacert.pem -O "$HOME/etc/ssl/cacert.pem"
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
