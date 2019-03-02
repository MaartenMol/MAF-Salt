firewalld:
  enabled: True
  default_zone: public
  zones:
    public:
      short: Public
      description: "For use in public areas. You do not trust the other computers on networks to not harm your computer. Only selected incoming connections are accepted."
      services:
        - http
        - https
        - ssh
        - dhcpv6-client
      ports:
        - 4505/tcp    #Salt Master Communications
        - 4506/tcp    #Salt Master Communications
        - 2377/tcp    #Docker Swarm Manager Copmmunications
        - 7946/tcp    #Container Network Discovery TCP
        - 7946/udp    #Container Network Discovery UDP
        - 4789/udp    #Container Ingress Networking