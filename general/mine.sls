/srv/pillar/top.sls:
  file.managed:
    - source: salt://general/mine_files/top.sls
    - user: root
    - group: root
    - mode: 644

/srv/pillar/swarm.sls:
  file.managed:
    - source: salt://general/mine_files/swarm.sls
    - user: root
    - group: root
    - mode: 644