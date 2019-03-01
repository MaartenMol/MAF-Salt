base:
  '*':
    - base
  {% if "swarm-master" in grains.get('role', []) %}
    - docker:
        host:
          enabled: true
        swarm:
          role: manager
          advertise_addr: 192.168.0.185
          bind:
            address: 192.168.0.185
            port: 2377
  {% endif %}
  {% if "swarm-worker" in grains.get('role', []) %}
    - docker:
        host:
          enabled: true
        swarm:
          role: worker
          master:
            host: 192.168.0.185
            port: 2377
  {% endif %}