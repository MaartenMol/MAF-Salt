maf firewall rules workers:
  firewalld.present:
    - name: public
    - default: True
    - services:
      - ssh
    - ports:
      - 7946/tcp    #Container Network Discovery TCP
      - 7946/udp    #Container Network Discovery UDP
      - 4789/udp    #Container Ingress Networking