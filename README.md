# MAF-Salt
## Prerequisites
* 3 nodes named:\
    master1.maf.cloud\
    minion1.maf.cloud\
    minion2.maf.cloud
* 2Gb ram
* 1 vCPU
* 100GB extra sata disk

# Install Salt
### On the master:
* yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm 
* yum install salt-minion -y 
* yum install salt-master -y 
* systemctl stop firewalld # temp salt enables this again
* systemctl start salt-minion 
* systemctl enable salt-minion 
* systemctl start salt-master 
* systemctl enable salt-master 

#### Add Salt Node Groups Based on Host Names
##### Edit the cat line like this:
https://img.rikmerkens.nl/Dxks.png

cat <<EOT >> /etc/salt/master.d/nodegroups.conf  
nodegroups: 
  swarmmanager: 'master*' 
  swarmworker: 'worker*' 
EOT  
  
### On the minions:
* yum install https://repo.saltstack.com/yum/redhat/salt-repo-latest-2.el7.noarch.rpm 
* yum install salt-minion -y 
* sed -i "/#master:/c\master: master.maf.cloud" /etc/salt/minion 
* systemctl start salt-minion 
* systemctl enable salt-minion

### Back on the master:
* git clone https://github.com/MaartenMol/MAF-Salt.git /srv/salt

#### Apply states
* cd /srv/salt
* salt '*' state.apply

#### Run Docker Swarm Orchestrator
* salt-run state.orchestrate docker.bootstrap
