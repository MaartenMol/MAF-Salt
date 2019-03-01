docker:
  host:
    enabled: true
  swarm:
    role: manager
    advertise_addr: 192.168.0.185
    bind:
      address: 192.168.0.185
      port: 2377

install_ctop:
  cmd.run:
    - name: |
       wget https://github.com/bcicen/ctop/releases/download/v0.7.2/ctop-0.7.2-linux-amd64 -O /usr/local/bin/ctop && chmod +x /usr/local/bin/ctop