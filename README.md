# MAF-Salt

git clone https://github.com/MaartenMol/MAF-Salt.git /srv/salt
ln -s /srv/salt/pillar /srv/pillar

salt -G 'role:swarm-master' state.highstate

salt -G 'role:swarm-worker' state.highstate
