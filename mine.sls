/etc/salt/minion.d/swarm.conf:
  file.managed:
    - source: salt://files/swarm.conf
    - require:
      - pkg: docker-ce