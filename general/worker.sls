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

/etc/consul.d/client/:
  file.directory:
    - user: root
    - group: consul
    - dir_mode: 660
    - makedirs: True

/usr/local/bin/consul:
  file.managed:
    - source: salt://general/files/consul_1.4.2_linux_amd64
    - user: root
    - group: root
    - mode: 755

consul-agent_systemd:
  file.managed:
    - name: /etc/systemd/system/consul-agent.service
    - source: salt://general/files/consul-agent.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: consul-agent_systemd

consul_check_node:
  file.managed:
    - name: /etc/consul.d/client/check_node.json
    - source: salt://general/files/consul/check_node.sjon
  module.run:
    - name: service.consul-agent_reload
    - onchanges:
      - file: consul_check_node

consul-agent_running:
  service.running:
    - name: consul-agent
    - watch:
      - module: consul-agent_systemd

