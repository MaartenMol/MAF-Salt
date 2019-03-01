add_repository_salt:
  pkg.installed:
    - sources:
      - salt-repo: https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm

add_repository_docker:
  cmd.run:
    - name: |
       yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

intall_packages:
  pkg.installed:
    - pkgs:
      - wget
      - nano
      - epel-release
      - yum-utils
      - policycoreutils-python
      - selinux-policy-targeted
      - device-mapper-persistent-data
      - lvm2

firewalld:
  service.dead:
    - enable: False
    - reload: False

disabled:
  selinux.mode