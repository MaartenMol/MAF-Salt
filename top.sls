base:
  'swarmmanager':
    - match: nodegroup
    - general.base
    - general.manager
    - firewall.manager
    - general.mine
    - docker.base

  'swarmworker':
    - match: nodegroup
    - general.base
    - general.worker
    - firewall.worker
    - docker.base