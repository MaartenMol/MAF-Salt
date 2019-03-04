/var/db/consul/:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: True

/etc/consul.d/client/:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 755
    - makedirs: True

/usr/local/bin/consul:
  file.managed:
    - source: salt://general/files/consul_1.4.2_linux_amd64
    - user: root
    - group: root
    - mode: 755

/usr/local/bin/start_agent.sh:
  file.managed:
    - source: salt://general/files/consul/start_agent.sh
    - user: root
    - group: root
    - mode: 755

/etc/consul.d/client/config.json:
  file.managed:
    - source: salt://general/files/consul/config-agent.json
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
    - source: salt://general/files/consul/check_node.json

consul-agent_running:
  service.running:
    - name: consul-agent
    - enable: True
    - watch:
      - module: consul-agent_systemd


