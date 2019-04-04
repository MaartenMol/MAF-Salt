base:
  'swarmmanager':
    - match: nodegroup
    - general.base
    - general.manager
    - general.mine
    - docker.base
    - firewall.manager

  'swarmworker':
    - match: nodegroup
    - general.base
    - general.worker
    - docker.base
    - firewall.worker