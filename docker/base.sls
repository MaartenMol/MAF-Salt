docker prerequisites:
  pkg.installed:
    - pkgs:
      - policycoreutils-python
      - selinux-policy-targeted
      - device-mapper-persistent-data
      - lvm2

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

disabled:
  selinux.mode