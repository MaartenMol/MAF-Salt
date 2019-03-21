ip=$(python -c 'import socket; print socket.gethostbyname(socket.getfqdn())')
/usr/local/bin/consul agent -config-dir=/etc/consul.d/client -rejoin -ui -data-dir=/var/db/consul -bind=${ip}