#!/bin/sh

echo "Adding port $APP_PORT to envoy.yaml"
( echo "cat <<EOF >/etc/envoy.yaml";
  cat /etc/envoy.yaml;
  echo "EOF";
) >/tmp/temp.yml
. /tmp/temp.yml
rm -f /tmp/temp.yml


echo "Creating a X509 certificate for $DNS_NAME"
mkdir -p /etc/ssl

openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/envoy.key -out /etc/ssl/envoy.crt -subj "/CN=$DNS_NAME"

/usr/local/bin/envoy -c /etc/envoy.yaml
