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

/dev/sdb:
  lvm.pv_present

vg_gluster:
  lvm.vg_present:
    - devices: /dev/sdb

lv_gluster:
  lvm.lv_present:
    - vgname: vg_gluster
    - size: 100%FREE

/gluster:
  mount.mounted:
    - device: /dev/sdb
    - fstype: xfs
    - opts: noatime
    - dump: 0
    - pass_num: 0
    - persist: True
    - mkmnt: True