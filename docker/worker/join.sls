{% set join_token = salt['mine.get']('*', 'worker_token').items()[0][1] %}
{% set join_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}

include:
  - docker.base

join cluster:
  cmd.run:
    - name: 'docker swarm join --token {{ join_token }} {{ join_ip }}:2377'
    - require:
      - pkg: docker-ce

install gluster volume plugin:
  cmd.run:
    - name: 'docker plugin install --alias glusterfs trajano/glusterfs-volume-plugin --grant-all-permissions'
    - require:
      - pkg: docker-ce

install vsphere volume plugin:
  cmd.run:
    - name: 'docker plugin install --grant-all-permissions --alias vsphere vmware/vsphere-storage-for-docker:latest'
    - require:
      - pkg: docker-ce