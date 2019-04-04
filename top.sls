base:
  'swarmmanager':
    - match: nodegroup
    - general.base
    - general.manager
    - general.mine
    - docker.base
    - docker.gluster
    - firewall.manager

  'swarmworker':
    - match: nodegroup
    - general.base
    - general.worker
    - docker.base
    - docker.gluster
    - firewall.worker