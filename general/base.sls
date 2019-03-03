repositories salt:
  pkg.installed:
    - sources:
      - salt-repo: https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm

repositories prerequisites:
  pkg.installed:
    - pkgs:
      - epel-release
      - centos-release-gluster5

base_packages:
  pkg.installed:
    - pkgs:
      - wget
      - nano
      - yum-utils