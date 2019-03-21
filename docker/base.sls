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
      - master.maf.cloud
      - minion1.maf.cloud
      - minion2.maf.cloud

volume swarmVol replicated with arbiter brick:
  glusterfs.volume_present:
    - name: swarmVol
    - bricks:
      - master.maf.cloud:/gluster/volumes/swarmVol
      - minion1.maf.cloud:/gluster/volumes/swarmVol
      - minion2.maf.cloud:/gluster/volumes/swarmVol
    - replica: 3
    - arbiter: True
    - start: True

volume monitoring replicated with arbiter brick:
  glusterfs.volume_present:
    - name: monitoring
    - bricks:
      - master.maf.cloud:/gluster/volumes/monitoring
      - minion1.maf.cloud:/gluster/volumes/monitoring
      - minion2.maf.cloud:/gluster/volumes/monitoring
    - replica: 3
    - arbiter: True
    - start: True

volume grafana replicated with arbiter brick:
  glusterfs.volume_present:
    - name: monitoring
    - bricks:
      - master.maf.cloud:/gluster/volumes/grafana
      - minion1.maf.cloud:/gluster/volumes/grafana
      - minion2.maf.cloud:/gluster/volumes/grafana
    - replica: 3
    - arbiter: True
    - start: True

/usr/local/bin/ctop:
  file.managed:
    - source: salt://docker/files/ctop-0.7.2-linux-amd64
    - user: root
    - group: root
    - mode: 755

disabled:
  selinux.mode