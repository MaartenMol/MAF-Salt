firewalld:
  service.running:
    - enable: True

public:
  firewalld.present:
    - prune_services: True
    - services:
      - ssh
    - prune_ports: True
    - ports:
      - 4505/tcp    #Salt Master Communications
      - 4506/tcp    #Salt Master Communications
      - 2377/tcp    #Docker Swarm Manager Copmmunications
      - 7946/tcp    #Container Network Discovery TCP
      - 7946/udp    #Container Network Discovery UDP
      - 4789/udp    #Container Ingress Networking
  service.running:
    - name: firewalld
    - reload: True
    - watch:
      - firewalld: public