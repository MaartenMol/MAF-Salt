/etc/salt/minion.d/swarm.conf:
  file.managed:
    - source: salt://docker/files/swarm.conf
    - require:
      - pkg: docker-ce