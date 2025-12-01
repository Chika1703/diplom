output "vpc_id" {
  value = twc_vpc.main.id
}

output "nat_ip" {
  value = twc_floating_ip.nat_ip.ip
}

output "lb_ip" {
  value = twc_floating_ip.lb_ip.ip
}

output "lamp_ips" {
  value = [for s in twc_server.lamp_group : s.local_network[0].ip]
}
