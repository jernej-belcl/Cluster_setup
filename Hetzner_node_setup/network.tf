resource "hcloud_network" "hcloud_private_network" {
  name     = var.vpc_name
  ip_range = var.ip_range_network
}

resource "hcloud_network_subnet" "hc_private_subnet" {
  network_id   = hcloud_network.hcloud_private_network.id
  type         = "cloud"
  network_zone = "eu-central"
  ip_range     = var.ip_range_subnet_hccm

  depends_on = [
    hcloud_network.hcloud_private_network
  ]
}
