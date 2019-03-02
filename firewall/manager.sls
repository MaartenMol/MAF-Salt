public:
  firewalld.present:
    - name: public
    - default: True
    - ports:
      - 22/tcp      #SSH
      - 2377/tcp    #Docker Swarm Manager Copmmunications
      - 7946/tcp    #Container Network Discovery TCP
      - 7946/udp    #Container Network Discovery UDP
      - 4789/udp    #Container Ingress Networking