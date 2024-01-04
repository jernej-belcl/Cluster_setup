output "registration_command" {
  sensitive = true
  value     = rancher2_cluster_v2.terraform_cluster.cluster_registration_token[0].token
}