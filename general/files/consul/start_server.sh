ip=$(dig +short `hostname -f`)
/usr/local/bin/consul agent -config-dir=/etc/consul.d/server -rejoin -ui -data-dir=/var/db/consul -bind=${ip}