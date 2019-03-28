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
      - open-vm-tools

prometheus:
  user.present:
    - fullname: Prometheus Service Account
    - shell: /bin/bash

/usr/local/bin/node_exporter:
  file.managed:
    - source: salt://general/files/node_exporter-0.17.0.linux-amd64
    - user: root
    - group: root
    - mode: 755

node_exporter_systemd:
  file.managed:
    - name: /etc/systemd/system/node_exporter.service
    - source: salt://general/files/node_exporter.service
  module.run:
    - name: service.systemctl_reload
    - onchanges:
      - file: node_exporter_systemd

node_exporter_running:
  service.running:
    - name: node_exporter
    - enable: True
    - watch:
      - module: node_exporter_systemd

/dev/sdb:
  lvm.pv_present

vg_gluster:
  lvm.vg_present:
    - devices: /dev/sdb

lv_gluster:
  lvm.lv_present:
    - vgname: vg_gluster
    - size: 80G

/dev/vg_gluster/lv_gluster:
  blockdev.formatted:
    - fs_type: xfs
    - force: True

/gluster:
  mount.mounted:
    - device: /dev/vg_gluster/lv_gluster
    - fstype: xfs
    - opts: noatime
    - dump: 0
    - pass_num: 0
    - persist: True
    - mkmnt: True