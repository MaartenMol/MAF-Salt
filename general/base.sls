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

firewalld:
  service.running:
    - enable: True
    - reload: True
    - watch:
      - pkg: firewalld