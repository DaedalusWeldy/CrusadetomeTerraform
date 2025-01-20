locals {
  nsg_rules = {
    ssh = {
      name                   = "SSH"
      priority               = 1001
      destination_port_range = "22"
    },
    http = {
      name                   = "HTTP"
      priority               = 1002
      destination_port_range = "80"
    }
  }

  custom_data = <<CUSTOM_DATA
#!/bin/bash
sudo apt update && sudo apt upgrade -y
sudo apt install -y docker.io
sudo groupadd docker
sudo usermod -aG docker adminuser
newgrp docker
sudo mkdir -p /etc/iptables/
sudo iptables -A INPUT -p tcp --dport 8501 -j ACCEPT
sudo sh -c "iptables-save > /etc/iptables/rules.v4"
echo ${var.ghcr_password} | docker login ghcr.io/daedalusweldy -u darrelltang --password-stdin
docker pull ghcr.io/daedalusweldy/crusadetomedataentry:latest
docker run -d --name dataentry -p 80:8501 ghcr.io/daedalusweldy/crusadetomedataentry:latest
CUSTOM_DATA
}
