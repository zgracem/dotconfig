# OpenSSL

export CURL_CA_BUNDLE="/usr/local/etc/openssl/certs/ca-bundle.crt"

if [[ ! -f $CURL_CA_BUNDLE ]]; then
    unset CURL_CA_BUNDLE
fi
