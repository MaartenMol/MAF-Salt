firewalld:
  service.running:
    - enable: True

/usr/lib/firewalld/services/consul.xml:
  file.managed:
    - source: salt://firewall/files/consul.xml
    - user: root
    - group: root
    - mode: 660

public:
  firewalld.present:
    - prune_services: True
    - services:
      - ssh
      - glusterfs
      - consul
    - prune_ports: True
    - ports:
      - 4505/tcp        #Salt Master Communications
      - 4506/tcp        #Salt Master Communications
      - 2377/tcp        #Docker Swarm Manager Copmmunications
      - 7946/tcp        #Container Network Discovery TCP
      - 7946/udp        #Container Network Discovery UDP
      - 4789/udp        #Container Ingress Networking
      - 9100/tcp        #Node_Exporter
      - 4040/tcp        #WeaveScope GUI
      # - 111/tcp         #Gluster Portmapper TCP
      # - 111/udp         #Gluster Portmapper UDP
      # - 24007/tcp       #Gluster Deamon
      # - 24008/tcp       #Gluster Management
      # - 49152-49160/tcp #Gluster Bricks
      # - 38465-38467/tcp #Gluster NFS Service
  service.running:
    - name: firewalld
    - reload: True
    - watch:
      - firewalld: public

restart salt-minion:
  cmd.run:
    - name: 'systemctl restart salt-minion'