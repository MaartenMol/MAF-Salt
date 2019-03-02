#{% set manager_ip = salt['mine.get']('*', 'manager_ip').items()[0][1][0] %}
#{% set manager_ip = salt['mine.get']('*', 'manager_ip').items() %}
#{% set manager_ip = salt['mine.get']('*', 'network.ip_addrs').items() %}
#{%- do salt.log.error(manager_ip) -%}
{% set test_ip = salt['dnsutil.A']('master.maf.cloud')[0] %}
#{% do salt.log.error(test_ip) %}
include:
 - docker.base
init new swarm cluster:
  cmd.run:
    - name: |
       docker swarm init --advertise-addr ens32
    - require:
      - pkg: docker-ce