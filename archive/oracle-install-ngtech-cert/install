#!/usr/bin/env bash

CA_CERT_FILE="ca-cert-only.crt"
CP_CERT_FILE="checkpoint-2021-latest-ca.crt"

MAIN_CERT_URL="https://gist.githubusercontent.com/elico/414ba276b1d7f111c8108dc1f5ee738b/raw/2ce7930f5fc582c69d37448d84a17c24c6e440a8/main-cert.pem"
CP_CERT_URL="https://gist.githubusercontent.com/elico/414ba276b1d7f111c8108dc1f5ee738b/raw/2ce7930f5fc582c69d37448d84a17c24c6e440a8/checkpoint-2021-cert.pem"

if [ ! -f "${CA_CERT_FILE}" ]; then
	wget "${MAIN_CERT_URL}" -O "${CA_CERT_FILE}"
fi

if [ ! -f "${CP_CERT_FILE}" ];then
	wget "${CP_CERT_URL}" -O "${CP_CERT_FILE}"
fi

#cp -v ca-cert-only.crt /usr/local/share/ca-certificates/
cp -v ca-cert-only.crt /etc/pki/ca-trust/source/anchors/
cp -v checkpoint-2021-latest-ca.crt /etc/pki/ca-trust/source/anchors/
update-ca-trust
