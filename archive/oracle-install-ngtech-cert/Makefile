all: download-crt-cert convert-crt-to-pem install-cert
	echo "OK, installed"

install-cert:
	cp -v ca-cert-only.crt /etc/pki/ca-trust/source/anchors/ca-cert-only.crt
	cp -v checkpoint-2021-latest-ca.crt /etc/pki/ca-trust/source/anchors/checkpoint-2021-latest-ca.crt
	update-ca-trust

uninstall-cert:
	rm -vf /etc/pki/ca-trust/source/anchors/checkpoint-2021-latest-ca.crt
	rm -vf /etc/pki/ca-trust/source/anchors/ca-cert-only.crt
	update-ca-trust

download-pem-cert:
	wget http://ngtech.co.il/certs/ca-cert-only.pem -O ca-cert-only.pem

download-crt-cert:
	wget http://ngtech.co.il/certs/ca-cert-only.pem -O ca-cert-only.crt

convert-crt-to-pem:
	openssl x509 -in ca-cert-only.crt -out ca-cert-only.pem -outform PEM

