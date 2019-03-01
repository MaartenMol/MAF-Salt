{% set manager_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}

include:
  - docker.base

init new swarm cluster:
  cmd.run:
    - name: 'docker swarm init --advertise-addr {{ manager_ip }}'
    - require:
      - pkg: docker-ce