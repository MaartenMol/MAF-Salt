{% set join_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}

include:
 - docker.base

peer-clusters:
  glusterfs.peered:
    - names:
      - master-01.maf.cloud
      - worker-01.maf.cloud
      - worker-02.maf.cloud
      - worker-03.maf.cloud
      - worker-04.maf.cloud
      - worker-05.maf.cloud

init cluster:
  cmd.run:
    - name: 'docker swarm init --advertise-addr {{ join_ip }}'
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

volume portainer replicated with arbiter brick:
  glusterfs.volume_present:
    - name: portainer
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/portainer
      - worker-01.maf.cloud:/gluster/volumes/portainer
      - worker-02.maf.cloud:/gluster/volumes/portainer
      - worker-03.maf.cloud:/gluster/volumes/portainer
      - worker-04.maf.cloud:/gluster/volumes/portainer
      - worker-05.maf.cloud:/gluster/volumes/portainer
    - replica: 3
    - arbiter: True
    - start: True

volume grafana replicated with arbiter brick:
  glusterfs.volume_present:
    - name: grafana
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/grafana
      - worker-01.maf.cloud:/gluster/volumes/grafana
      - worker-02.maf.cloud:/gluster/volumes/grafana
      - worker-03.maf.cloud:/gluster/volumes/grafana
      - worker-04.maf.cloud:/gluster/volumes/grafana
      - worker-05.maf.cloud:/gluster/volumes/grafana
    - replica: 3
    - arbiter: True
    - start: True

volume alertmanager replicated with arbiter brick:
  glusterfs.volume_present:
    - name: alertmanager
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/alertmanager
      - worker-01.maf.cloud:/gluster/volumes/alertmanager
      - worker-02.maf.cloud:/gluster/volumes/alertmanager
      - worker-03.maf.cloud:/gluster/volumes/alertmanager
      - worker-04.maf.cloud:/gluster/volumes/alertmanager
      - worker-05.maf.cloud:/gluster/volumes/alertmanager
    - replica: 3
    - arbiter: True
    - start: True

volume elastalert replicated with arbiter brick:
  glusterfs.volume_present:
    - name: elastalert
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/elastalert
      - worker-01.maf.cloud:/gluster/volumes/elastalert
      - worker-02.maf.cloud:/gluster/volumes/elastalert
      - worker-03.maf.cloud:/gluster/volumes/elastalert
      - worker-04.maf.cloud:/gluster/volumes/elastalert
      - worker-05.maf.cloud:/gluster/volumes/elastalert
    - replica: 3
    - arbiter: True
    - start: True

volume swirl-db replicated with arbiter brick:
  glusterfs.volume_present:
    - name: swirl-db
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/swirl-db
      - worker-01.maf.cloud:/gluster/volumes/swirl-db
      - worker-02.maf.cloud:/gluster/volumes/swirl-db
      - worker-03.maf.cloud:/gluster/volumes/swirl-db
      - worker-04.maf.cloud:/gluster/volumes/swirl-db
      - worker-05.maf.cloud:/gluster/volumes/swirl-db
    - replica: 3
    - arbiter: True
    - start: True