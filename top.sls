base:
  'swarmmanager':
    - match: nodegroup
    - docker.base

  'swarmworker':
    - match: nodegroup
    - docker.base

# base:
#   '*':
#     - base
#   {% if "swarm-master" in grains.get('role', []) %}
#     - swarm-master
#   {% endif %}
#   {% if "swarm-worker" in grains.get('role', []) %}
#     - swarm-worker
#   {% endif %}