# base:
#   '*':
#     - base
#   {% if "swarm-master" in grains.get('role', []) %}
#     - swarm-master
#   {% endif %}
#   {% if "swarm-worker" in grains.get('role', []) %}
#     - swarm-worker
#   {% endif %}

base:
  "*":
    - base
  "master*":
    - docker:
        host:
          enabled: true
        swarm:
          role: manager
          advertise_addr: 192.168.0.185
          bind:
            address: 192.168.0.185
            port: 2377
  "minion*":
    - docker:
        host:
          enabled: true
        swarm:
          role: worker
          master:
            host: 192.168.0.185
            port: 2377
