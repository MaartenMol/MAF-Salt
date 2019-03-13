{% set join_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}

include:
 - docker.base

init cluster:
  cmd.run:
    - name: 'docker swarm init --advertise-addr {{ join_ip }}'
    - require:
      - pkg: docker-ce

install gluster volume plugin:
  cmd.run:
    - name: 'docker plugin install sapk/plugin-gluster'
    - require:
      - pkg: docker-ce