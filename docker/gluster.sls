volume portainer replicated with arbiter brick:
  glusterfs.volume_present:
    - name: portainer
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/portainer
      - worker-01.maf.cloud:/gluster/volumes/portainer
      - worker-02.maf.cloud:/gluster/volumes/portainer
      - worker-03.maf.cloud:/gluster/volumes/portainer
      - worker-04.maf.cloud:/gluster/volumes/portainer
      - worker-05.maf.cloud:/gluster/volumes/portainer
    - replica: 3
    - arbiter: True
    - start: True

volume grafana replicated with arbiter brick:
  glusterfs.volume_present:
    - name: grafana
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/grafana
      - worker-01.maf.cloud:/gluster/volumes/grafana
      - worker-02.maf.cloud:/gluster/volumes/grafana
      - worker-03.maf.cloud:/gluster/volumes/grafana
      - worker-04.maf.cloud:/gluster/volumes/grafana
      - worker-05.maf.cloud:/gluster/volumes/grafana
    - replica: 3
    - arbiter: True
    - start: True

volume alertmanager replicated with arbiter brick:
  glusterfs.volume_present:
    - name: alertmanager
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/alertmanager
      - worker-01.maf.cloud:/gluster/volumes/alertmanager
      - worker-02.maf.cloud:/gluster/volumes/alertmanager
      - worker-03.maf.cloud:/gluster/volumes/alertmanager
      - worker-04.maf.cloud:/gluster/volumes/alertmanager
      - worker-05.maf.cloud:/gluster/volumes/alertmanager
    - replica: 3
    - arbiter: True
    - start: True

volume elastalert replicated with arbiter brick:
  glusterfs.volume_present:
    - name: elastalert
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/elastalert
      - worker-01.maf.cloud:/gluster/volumes/elastalert
      - worker-02.maf.cloud:/gluster/volumes/elastalert
      - worker-03.maf.cloud:/gluster/volumes/elastalert
      - worker-04.maf.cloud:/gluster/volumes/elastalert
      - worker-05.maf.cloud:/gluster/volumes/elastalert
    - replica: 3
    - arbiter: True
    - start: True

volume swirl-db replicated with arbiter brick:
  glusterfs.volume_present:
    - name: swirl-db
    - bricks:
      - master-01.maf.cloud:/gluster/volumes/swirl-db
      - worker-01.maf.cloud:/gluster/volumes/swirl-db
      - worker-02.maf.cloud:/gluster/volumes/swirl-db
      - worker-03.maf.cloud:/gluster/volumes/swirl-db
      - worker-04.maf.cloud:/gluster/volumes/swirl-db
      - worker-05.maf.cloud:/gluster/volumes/swirl-db
    - replica: 3
    - arbiter: True
    - start: True