base:
  'swarmmanager':
    - match: nodegroup
    - general.base
    - firewall.manager
    - general.mine
    - docker.base

  'swarmworker':
    - match: nodegroup
    - general.base
    - firewall.worker
    - docker.base