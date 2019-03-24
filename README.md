# MAF-Salt
## Add a second disk first!
SATA ~100GB

# Install Salt
### On the master:
yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm \
yum install salt-minion -y \
yum install salt-master -y \
systemctl stop firewalld    # temporarily salt fixes this later \
systemctl start salt-minion \ 
systemctl enable salt-minion \
systemctl start salt-master \
systemctl enable salt-master \

### Add Salt Node Groups Based on Host Names
cat <<EOT >> /etc/salt/master.d/nodegroups.conf  \
nodegroups:
  swarmmanager: 'master*'
  swarmworker: 'worker*'
EOT  
  
### On the minions:
yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm
yum install salt-minion -y
sed -i "/#master:/c\master: master.maf.cloud" /etc/salt/minion
systemctl start salt-minion
systemctl enable salt-minion

### Clone git
git clone https://github.com/MaartenMol/MAF-Salt.git /srv/salt

### Apply states
cd /srv/salt
salt '*' state.apply

### Run Docker Swarm Orchestrator
salt-run state.orchestrate docker.bootstrap
