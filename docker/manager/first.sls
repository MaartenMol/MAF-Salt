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
    - name: 'docker plugin install sapk/plugin-gluster:v1.0.7-3 --grant-all-permissions'
    - require:
      - pkg: docker-ce