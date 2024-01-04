resource "hcloud_server" "all_roles_master" {
  count       = var.all_roles_instances
  name        = "${var.all_roles_master_name}${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.jb-ssh-key.id]
  network {
    network_id = hcloud_network.hcloud_private_network.id
  }
  # Prevent updates to the "network" block's "ip" attribute
  lifecycle {
    ignore_changes = [
      network
    ]
  }
  # **Note**: the depends_on is important when directly attaching the
  # server to a network. Otherwise Terraform will attempt to create
  # server and sub-network in parallel. This may result in the server
  # creation failing randomly.
  depends_on = [
    hcloud_network_subnet.hc_private_subnet,
    hcloud_ssh_key.jb-ssh-key
  ]

}

resource "hcloud_server" "master" {
  count       = var.master_instances
  name        = "${var.master_name}${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.jb-ssh-key.id]

  network {
    network_id = hcloud_network.hcloud_private_network.id
  }

  depends_on = [
    hcloud_network_subnet.hc_private_subnet,
    hcloud_ssh_key.jb-ssh-key
  ]

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}

resource "hcloud_server" "worker" {
  count       = var.worker_instances
  name        = "${var.worker_name}${count.index}"
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  ssh_keys    = [hcloud_ssh_key.jb-ssh-key.id]

  network {
    network_id = hcloud_network.hcloud_private_network.id
  }

  depends_on = [
    hcloud_network_subnet.hc_private_subnet,
    hcloud_ssh_key.jb-ssh-key
  ]

  lifecycle {
    ignore_changes = [
      network
    ]
  }
}