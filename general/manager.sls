consul:
  user.present:
    - fullname: Consul Service Account
    - shell: /bin/bash

/var/db/consul/:
  file.directory:
    - user: root
    - group: consul
    - dir_mode: 660
    - makedirs: True

/etc/consul.d/server/:
  file.directory:
    - user: root
    - group: consul
    - dir_mode: 660
    - makedirs: True

/usr/local/bin/consul:
  file.managed:
    - source: salt://general/files/consul_1.4.2_linux_amd64
    - user: root
    - group: consul
    - mode: 755

/etc/consul.d/server/config.json:
  file.managed:
    - source: salt://general/files/consul/config-server.json
    - user: root
    - group: consul
    - mode: 660

consul-server_systemd:
  file.managed:
    - name: /etc/systemd/system/consul-server.service
    - source: salt://general/files/consul-server.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: consul-server_systemd

consul-server_running:
  service.running:
    - name: consul-server
    - enable: True
    - watch:
      - module: consul-server_systemd
