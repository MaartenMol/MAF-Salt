docker prerequisites:
  pkg.installed:
    - pkgs:
      - policycoreutils-python
      - selinux-policy-targeted
      - device-mapper-persistent-data
      - lvm2
      - glusterfs-server

docker:
  pkgrepo.managed:
    - humanname: Docker CE Stable
    - baseurl: https://download.docker.com/linux/centos/7/$basearch/stable
    - gpgkey: https://download.docker.com/linux/centos/gpg
    - gpgcheck: 1
  service.running:
    - enable: True
    - require:
      - pkg: docker-ce

docker-ce:
  pkg.installed:
    - require:
      - pkgrepo: docker

glusterd:
  service.running:
    - enable: True

/gluster/volumes:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 777
    - makedirs: True

peer-clusters:
  glusterfs.peered:
    - names:
      - master-01.maf.cloud
      - worker-01.maf.cloud
      - worker-02.maf.cloud

volume portainer replicated with arbiter brick:
  glusterfs.volume_present:
    - name: portainer
    - bricks:
      - master-01.cloud:/gluster/volumes/portainer
      - worker-01.cloud:/gluster/volumes/portainer
      - worker-02.cloud:/gluster/volumes/portainer
    - replica: 3
    - arbiter: True
    - start: True

volume grafana replicated with arbiter brick:
  glusterfs.volume_present:
    - name: grafana
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/grafana
      - minion-01.maf.cloud:/gluster/volumes/grafana
      - minion-02.maf.cloud:/gluster/volumes/grafana
    - replica: 3
    - arbiter: True
    - start: True

volume alertmanager replicated with arbiter brick:
  glusterfs.volume_present:
    - name: alertmanager
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/alertmanager
      - minion-01.maf.cloud:/gluster/volumes/alertmanager
      - minion-02.maf.cloud:/gluster/volumes/alertmanager
    - replica: 3
    - arbiter: True
    - start: True

volume mafApiDB replicated with arbiter brick:
  glusterfs.volume_present:
    - name: mafApiDB
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/mafApiDB
      - minion-01.maf.cloud:/gluster/volumes/mafApiDB
      - minion-02.maf.cloud:/gluster/volumes/mafApiDB
    - replica: 3
    - arbiter: True
    - start: True

volume elastalert replicated with arbiter brick:
  glusterfs.volume_present:
    - name: elastalert
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/elastalert
      - minion-01.maf.cloud:/gluster/volumes/elastalert
      - minion-02.maf.cloud:/gluster/volumes/elastalert
    - replica: 3
    - arbiter: True
    - start: True

volume swirl-db replicated with arbiter brick:
  glusterfs.volume_present:
    - name: swirl-db
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/swirl-db
      - minion-01.maf.cloud:/gluster/volumes/swirl-db
      - minion-02.maf.cloud:/gluster/volumes/swirl-db
    - replica: 3
    - arbiter: True
    - start: True

/usr/local/bin/ctop:
  file.managed:
    - source: salt://docker/files/ctop-0.7.2-linux-amd64
    - user: root
    - group: root
    - mode: 755

/usr/local/bin/scope:
  file.managed:
    - source: salt://docker/files/scope-1.10.2-linux-amd64
    - user: root
    - group: root
    - mode: 755

disabled:
  selinux.mode