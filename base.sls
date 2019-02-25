add_repository_salt:
  pkg.installed:
    - sources:
      - salt-repo: https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm 

add_repository_docker:
  cmd.run:
    - name: |
       yum-config-manager --add-repo https://download.docker.com/linux/centos/docker-ce.repo

/etc/yum.repos.d/kubernetes.repo:
  file.managed:
    - source: salt://reqs/kubernetes.repo

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


add_enabled_iptables:
  cmd.run:
    - name: |
       echo "1" > /proc/sys/net/bridge/bridge-nf-call-iptables

disabled:
  selinux.mode

