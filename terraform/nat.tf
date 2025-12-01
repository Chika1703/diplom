resource "twc_floating_ip" "nat_ip" {
  availability_zone = "msk-1"
  ddos_guard        = false
}

resource "twc_server" "nat" {
  name                      = "nat-instance"
  preset_id                 = var.nat_preset_id
  os_id                     = var.nat_os_id
  project_id                = var.project_id
  availability_zone         = "msk-1"
  ssh_keys_ids              = [var.ssh_key_id]
  floating_ip_id            = twc_floating_ip.nat_ip.id
  is_root_password_required = false

  local_network {
    id = twc_vpc.main.id
    ip = "192.168.0.220"
  }

  provisioner "remote-exec" {
    inline = [
      "mkdir -p /root/.ssh",
      "echo '${file(var.private_key_path)}' > /root/.ssh/id_rsa",
      "chmod 600 /root/.ssh/id_rsa",
      "sudo sysctl -w net.ipv4.ip_forward=1",
      "echo 'net.ipv4.ip_forward = 1' | sudo tee -a /etc/sysctl.conf",
      "sudo apt-get update -y",
      "sudo DEBIAN_FRONTEND=noninteractive apt-get install -y iptables-persistent",
      "sudo iptables -t nat -A POSTROUTING -s 192.168.0.0/24 -o eth0 -j MASQUERADE",
      "sudo iptables -A FORWARD -s 192.168.0.0/24 -o eth0 -j ACCEPT",
      "sudo iptables -A FORWARD -d 192.168.0.0/24 -m state --state ESTABLISHED,RELATED -i eth0 -j ACCEPT",
      "sudo netfilter-persistent save"
    ]

    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.private_key_path)
      host        = twc_floating_ip.nat_ip.ip
    }
  }
}
