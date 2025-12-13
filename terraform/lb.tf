resource "twc_floating_ip" "lb_ip" {
  availability_zone = "msk-1"
  ddos_guard        = false
}

resource "twc_lb" "lamp_lb" {
  name              = "lamp-lb"
  preset_id         = 1115
  project_id        = var.project_id
  availability_zone = "msk-1"
  algo              = "roundrobin"
  maxconn           = 10000
  client_timeout    = 20000
  connect_timeout   = 20000
  server_timeout    = 20000
  httprequest_timeout = 20000
  is_keepalive      = false
  is_ssl            = false
  is_sticky         = false
  is_use_proxy      = false
  floating_ip_id    = twc_floating_ip.lb_ip.id
  ips = [
    for srv in twc_server.lamp_group :
    srv.local_network[0].ip
  ]

  local_network {
    id = twc_vpc.main.id
    ip = "192.168.0.5"
  }

  health_check {
    fall    = 3
    inter   = 10
    path    = "/"
    port    = 30080
    proto   = "http"
    rise    = 2
    timeout = 5
  }
}

resource "twc_lb_rule" "app_http" {
  lb_id          = twc_lb.lamp_lb.id
  balancer_proto = "http"
  balancer_port  = 80
  server_proto   = "http"
  server_port    = 30080
}

resource "twc_lb_rule" "lamp_rule_https" {
  lb_id          = twc_lb.lamp_lb.id
  balancer_proto = "https"
  balancer_port  = 443
  server_proto   = "http"
  server_port    = 30080
}