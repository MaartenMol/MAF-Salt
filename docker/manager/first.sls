include:
  - docker.base

init new swarm cluster:
  cmd.run:
    - name: 'docker swarm init --advertise-addr '
    - require:
      - pkg: docker-ce