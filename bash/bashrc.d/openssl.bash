# OpenSSL

export SSL_CERT_DIR='/usr/local/etc/openssl'
export SSL_CERT_FILE="${SSL_CERT_DIR}/cert.pem"
export CURL_CA_BUNDLE="${SSL_CERT_DIR}/certs/ca-bundle.crt"

for thing in SSL_CERT_DIR SSL_CERT_FILE CURL_CA_BUNDLE; do
    if [[ ! -e ${!thing} ]]; then
        unset -v $thing
    fi
    unset -v thing
done

if [[ -n $SSL_CERT_FILE ]]; then
    export GIT_SSL_CAINFO="$SSL_CERT_FILE"
fi
