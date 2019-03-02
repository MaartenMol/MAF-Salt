firewalld:
  service.running:
    - reload: True
    - enable: True
    - watch:
      - firewalld: public
  present:
    - name: public
    - services:
      - ssh
    - ports:
      - 4505/tcp    #Salt Master Communications
      - 4506/tcp    #Salt Master Communications
      - 2377/tcp    #Docker Swarm Manager Copmmunications
      - 7946/tcp    #Container Network Discovery TCP
      - 7946/udp    #Container Network Discovery UDP
      - 4789/udp    #Container Ingress Networking
