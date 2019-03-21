{% set join_token = salt['mine.get']('*', 'manager_token').items()[0][1] %}
{% set join_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}

include:
  - docker.base
  - docker.mine

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ join_token }} {{ join_ip }}:2377'
    - require:
      - pkg: docker-ce

install gluster volume plugin:
  cmd.run:
    - name: 'docker plugin install sapk/plugin-gluster:v1.0.7-3 --grant-all-permissions'
    - require:
      - pkg: docker-ce