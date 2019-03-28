mine_functions:
  manager_token:
    - mine_function: cmd.run
    - "docker swarm join-token manager -q"
  manager_ip:
    - mine_function: network.ip_addrs
    - ens192
  worker_token:
    - mine_function: cmd.run
    - "docker swarm join-token worker -q"