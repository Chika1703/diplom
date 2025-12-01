resource "local_file" "inventory" {
  filename = "${path.module}/inventory.ini"
  content  = templatefile("${path.module}/inventory.tpl", {
    lamp_servers = [
      for s in twc_server.lamp_group : {
        name = s.name
        ip   = s.local_network[0].ip
      }
    ]
    nat_ip = twc_floating_ip.nat_ip.ip
  })
}
