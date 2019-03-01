repositories_salt:
  pkg.installed:
    - sources:
      - salt-repo: https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm

repositories_epel:
  pkg.installed:      
    - pkgs:
      - epel-release

base_packages:
  pkg.installed:
    - pkgs:
      - wget
      - nano
      - yum-utils
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

firewalld:
  service.dead:
    - enable: False
    - reload: False

disabled:
  selinux.mode