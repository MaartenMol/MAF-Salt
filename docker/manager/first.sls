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

restart dockerd:
  cmd.run:
    - name: 'systemctl restart docker'

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

volume grafana-postgres replicated with arbiter brick:
  glusterfs.volume_present:
    - name: grafana-postgres
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/grafana-postgres
      - worker-01.maf.cloud:/gluster/volumes/grafana-postgres
      - worker-02.maf.cloud:/gluster/volumes/grafana-postgres
      - worker-03.maf.cloud:/gluster/volumes/grafana-postgres
      - worker-04.maf.cloud:/gluster/volumes/grafana-postgres
      - worker-05.maf.cloud:/gluster/volumes/grafana-postgres
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

volume prometheus replicated with arbiter brick:
  glusterfs.volume_present:
    - name: prometheus
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/prometheus
      - worker-01.maf.cloud:/gluster/volumes/prometheus
      - worker-02.maf.cloud:/gluster/volumes/prometheus
      - worker-03.maf.cloud:/gluster/volumes/prometheus
      - worker-04.maf.cloud:/gluster/volumes/prometheus
      - worker-05.maf.cloud:/gluster/volumes/prometheus
    - replica: 3
    - arbiter: True
    - start: True

volume elasticsearch replicated with arbiter brick:
  glusterfs.volume_present:
    - name: elasticsearch
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/elasticsearch
      - worker-01.maf.cloud:/gluster/volumes/elasticsearch
      - worker-02.maf.cloud:/gluster/volumes/elasticsearch
      - worker-03.maf.cloud:/gluster/volumes/elasticsearch
      - worker-04.maf.cloud:/gluster/volumes/elasticsearch
      - worker-05.maf.cloud:/gluster/volumes/elasticsearch
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

volume mongo-data-01 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-data-01
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-data-01
      - worker-01.maf.cloud:/gluster/volumes/mongo-data-01
      - worker-02.maf.cloud:/gluster/volumes/mongo-data-01
      - worker-03.maf.cloud:/gluster/volumes/mongo-data-01
      - worker-04.maf.cloud:/gluster/volumes/mongo-data-01
      - worker-05.maf.cloud:/gluster/volumes/mongo-data-01
    - replica: 3
    - arbiter: True
    - start: True

volume mongo-data-02 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-data-02
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-data-02
      - worker-01.maf.cloud:/gluster/volumes/mongo-data-02
      - worker-02.maf.cloud:/gluster/volumes/mongo-data-02
      - worker-03.maf.cloud:/gluster/volumes/mongo-data-02
      - worker-04.maf.cloud:/gluster/volumes/mongo-data-02
      - worker-05.maf.cloud:/gluster/volumes/mongo-data-02
    - replica: 3
    - arbiter: True
    - start: True

volume mongo-data-03 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-data-03
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-data-03
      - worker-01.maf.cloud:/gluster/volumes/mongo-data-03
      - worker-02.maf.cloud:/gluster/volumes/mongo-data-03
      - worker-03.maf.cloud:/gluster/volumes/mongo-data-03
      - worker-04.maf.cloud:/gluster/volumes/mongo-data-03
      - worker-05.maf.cloud:/gluster/volumes/mongo-data-03
    - replica: 3
    - arbiter: True
    - start: True

volume mongo-cfg-01 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-cfg-01
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-cfg-01
      - worker-01.maf.cloud:/gluster/volumes/mongo-cfg-01
      - worker-02.maf.cloud:/gluster/volumes/mongo-cfg-01
      - worker-03.maf.cloud:/gluster/volumes/mongo-cfg-01
      - worker-04.maf.cloud:/gluster/volumes/mongo-cfg-01
      - worker-05.maf.cloud:/gluster/volumes/mongo-cfg-01
    - replica: 3
    - arbiter: True
    - start: True

volume mongo-cfg-02 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-cfg-02
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-cfg-02
      - worker-01.maf.cloud:/gluster/volumes/mongo-cfg-02
      - worker-02.maf.cloud:/gluster/volumes/mongo-cfg-02
      - worker-03.maf.cloud:/gluster/volumes/mongo-cfg-02
      - worker-04.maf.cloud:/gluster/volumes/mongo-cfg-02
      - worker-05.maf.cloud:/gluster/volumes/mongo-cfg-02
    - replica: 3
    - arbiter: True
    - start: True

volume mongo-cfg-03 replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mongo-cfg-03
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mongo-cfg-03
      - worker-01.maf.cloud:/gluster/volumes/mongo-cfg-03
      - worker-02.maf.cloud:/gluster/volumes/mongo-cfg-03
      - worker-03.maf.cloud:/gluster/volumes/mongo-cfg-03
      - worker-04.maf.cloud:/gluster/volumes/mongo-cfg-03
      - worker-05.maf.cloud:/gluster/volumes/mongo-cfg-03
    - replica: 3
    - arbiter: True
    - start: True