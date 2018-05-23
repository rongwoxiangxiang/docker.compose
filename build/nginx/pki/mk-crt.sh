#!/bin/bash
# 基于OpenSSL自建CA和颁发SSL证书
# https://segmentfault.com/a/1190000002569859

if [ ! -d "CA" ]; then
	mkdir CA
	pushd CA > /dev/null
	mkdir {private,newcerts}
	touch index.txt
	echo 01 > serial
	openssl genrsa -out private/ca.key 2048
	openssl req -new -sha256 -x509 \
		-key private/ca.key \
		-subj "//C=CN\O=Guanaitong\CN=Guanaitong Root CA" \
		-days 3650 \
		-out ca.crt
	popd > /dev/null
fi

if [ -f "tls/private/guanaitong.csr" ]; then
	rm tls/private/guanaitong.csr
fi
if [ -f "tls/certs/guanaitong.crt" ]; then
	rm tls/certs/guanaitong.crt
fi
openssl req -new -sha256 \
	-key tls/private/guanaitong.key \
	-subj "//C=CN\O=Guanaitong\CN=Guanaitong Internal" \
	-out tls/private/guanaitong.csr
openssl x509 -req -sha256 \
	-in tls/private/guanaitong.csr \
	-CA CA/ca.crt \
	-CAkey CA/private/ca.key \
	-CAcreateserial \
	-extensions SAN \
	-extfile guanaitong.cnf \
	-days 3650 \
	-out tls/certs/guanaitong.crt
# winpty openssl pkcs12 -export \
# 	-in tls/certs/guanaitong.crt \
# 	-inkey tls/private/guanaitong.key \
# 	-certfile CA/ca.crt \
# 	-name tomcat \
# 	-out tls/certs/tomcat.p12
cp -rf tls/* ../root/etc/ssl/
