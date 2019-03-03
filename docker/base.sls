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

/gluster/bricks:
  file.directory:
    - user: root
    - group: root
    - dir_mode: 660
    - makedirs: True

peer-cluster:
  glusterfs.peered:
    - name: three

peer-clusters:
  glusterfs.peered:
    - names:
      - master.maf.cloud
      - minion1.maf.cloud
      - minion2.maf.cloud

volume replicated with arbiter brick:
  glusterfs.volume_present:
    - name: swarmVol
    - bricks:
      - master.maf.cloud:/gluster/bricks
      - minion1.maf.cloud:/gluster/bricks
      - minion2.maf.cloud:/gluster/bricks
    - replica: 3
    - arbiter: True
    - start: True

install ctop:
  cmd.run:
    - name: 'wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop'
    - require:
      - pkg: docker-ce

disabled:
  selinux.mode