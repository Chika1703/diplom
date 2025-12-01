resource "twc_server" "lamp_group" {
  count             = 2
  name              = "lamp-server-${count.index + 1}"
  preset_id         = 4795
  os_id             = 99
  project_id        = var.project_id
  availability_zone = "msk-1"
  is_root_password_required = false
  ssh_keys_ids      = [var.ssh_key_id]

  local_network {
    id = twc_vpc.main.id
    ip = "192.168.0.${count.index + 10}"
  }
}
