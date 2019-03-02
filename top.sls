base:
  'swarmmanager':
    - match: nodegroup
    - general.base
    - general.mine
    - docker.base

  'swarmworker':
    - match: nodegroup
    - general.base
    - docker.base