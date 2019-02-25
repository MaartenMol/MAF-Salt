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
