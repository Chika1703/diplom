resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content  = templatefile("${path.module}/inventory.tpl", {
    nat_public_ip  = twc_floating_ip.nat_ip.ip
    nat_private_ip = twc_server.nat.local_network[0].ip
    k8s_workers = [
      for s in twc_server.lamp_group : {
        name = s.name
        ip   = s.local_network[0].ip
      }
    ]
  })
}
