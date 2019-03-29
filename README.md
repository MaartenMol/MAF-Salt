# MAF-Salt
## Prerequisites
* 3 nodes named:\
    MASTER-01.maf.cloud\
    WORKER-01.maf.cloud\
    WORKER-02.maf.cloud
* 3Gb ram
* 2 vCPU

# Install Salt
### On the master:
* ```yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && yum install -y salt-minion salt-master```
* ```systemctl enable salt-master && systemctl enable salt-minion```
* ```systemctl stop firewalld```
* ```sed -i "/#master:/c\master: MASTER-01.maf.cloud" /etc/salt/minion```
* ```wget https://gist.githubusercontent.com/MaartenMol/778fd2c1594ee693b67b187d2f1758a9/raw/4c01192d1e5dda306fb3c3925617fa4cd328ea22/nodegroups.conf -O /etc/salt/master.d/nodegroups.conf```
* ```systemctl start salt-master```
* ```systemctl start salt-minion```
  
### On the minions:
* ```yum install -y https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm && yum install -y salt-minion```
* ```sed -i "/#master:/c\master: MASTER-01.maf.cloud" /etc/salt/minion```
* ```systemctl start salt-minion && systemctl enable salt-minion```

### Back on the master:
* ```git clone https://github.com/MaartenMol/MAF-Salt.git /srv/salt```

#### Apply states
* ```cd /srv/salt```
* ```salt '*' state.apply```
* ```salt '*' saltutil.refresh_pillar```
* ```salt '*' pillar.items```
* ```salt '*' mine.update```

#### Run Docker Swarm Orchestrator
* ```salt-run state.orchestrate docker.bootstrap```
