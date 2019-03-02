# MAF-Salt

git clone https://github.com/MaartenMol/MAF-Salt.git /srv/salt

# Add Salt Node Groups Based on Host Names
/etc/salt/master.d/nodegroups.conf:
nodegroups:
  swarmmanager: 'master*'
  swarmworker: 'worker*'

# Apply states
salt '*' state.highstate apply

# Run Docker Swarm Orchestrator
salt-run state.orchestrate docker.bootstrap