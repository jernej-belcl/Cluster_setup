resource "local_file" "kube_config_server_yaml" {
  filename = var.kubeconfig_path
  content  = rancher2_cluster_v2.terraform_cluster.kube_config
}