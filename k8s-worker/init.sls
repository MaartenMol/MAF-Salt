intall_k8s_packages:
  pkg.installed:
    - pkgs: 
      - docker-ce 
      - kubelet 
      - kubeadm 
      - kubectl

ensure_cgroup-driver:
  cmd.run:
    - name: |
       sed -i 's/cgroup-driver=systemd/cgroup-driver=cgroupfs/g' /etc/systemd/system/kubelet.service.d/10-kubeadm.conf

docker:
  service.running:
    - enable: True
    - reload: True

kubelet:
  service.running:
    - enable: True
    - reload: True

join_k8s_cluster:
  cmd.run:
    - name: |
       kubeadm join master.maf.cloud:6443 --token dktxv0.g6w9ipqm7a4vcec2 --discovery-token-ca-cert-hash sha256:c06320c01bd257c0dbdab79fd182dd6fc19c48081baabe5bf2f2dba961c007af 

