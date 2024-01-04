module "rancher_cluster_setup" {
  source = "./Rancher_cluster_setup"
  api_url = var.api_url
  rancher2_access_key = var.rancher2_access_key
  rancher2_secret_key = var.rancher2_secret_key
  cluster_name = var.cluster_name
  kubeconfig_path = var.kubeconfig_path
  ip_range_cilium_subnet = var.ip_range_cilium_subnet
  rancher_kubernetes_version = var.rancher_kubernetes_version
}

module "hetzner_node_setup" {
  source = "./Hetzner_node_setup"
  master_name = var.master_name
  all_roles_master_name = var.all_roles_master_name
  vpc_name = var.vpc_name
  worker_name = var.worker_name
  cluster_token = module.rancher_cluster_setup.registration_command
  hcloud_token = var.hcloud_token
  master_instances = var.master_instances
  worker_instances = var.worker_instances
  ssh_private_key_path = var.ssh_private_key_path
  ssh_public_key_path = var.ssh_public_key_path
  ip_range_network = var.ip_range_network
  ip_range_subnet_hccm = var.ip_range_subnet_hccm
}

// Uncomment after the cluster is up
module "helm_setup" {
  source = "./Helm_setup"
  kubeconfig_path = var.kubeconfig_path
}