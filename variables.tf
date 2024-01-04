variable "api_url" {
  # default = "<your-api-token>"
}

variable "cluster_name" {
  # default = "terraform-cluster"
}

variable "rancher_kubernetes_version" {
  #type        = string
  #description = "Kubernetes version to use for Rancher server cluster"
  #default     = "v1.25.13+rke2r1"
}

variable "rancher2_access_key" {
  # default = "<rancher2_access_key>"
}

variable "rancher2_secret_key" {
  # default = "<rancher2_secret_key"
}

/*variable "wasabi_access_key" {
  # default = "<rancher2_access_key>"
}

variable "wasabi_secret_key" {
  # default = "<rancher2_secret_key"
}*/

variable "ip_range_cilium_subnet" {
  #default = "10.3.0.0/17"
}

variable "kubeconfig_path" {
  default = "Helm_setup/.kube/config"
}

# Hetzner

#declare value of your token here or in terraform.tfvars
variable "hcloud_token" {
  # default = <your-api-token>
}

variable "cluster_token" {
  //default = rancher2_cluster_v2.terraform_cluster.cluster_registration_token.token
}


variable "master_instances" {
  type = number
  #default = 4
}


variable "worker_instances" {
  type = number
  #default = 4
}

variable "ssh_private_key_path" {
}
variable "ssh_public_key_path" {
}
variable "vpc_name" {
  //default="vpc_terraform"
}
variable "all_roles_master_name" {
  //default="terraform-all-roles-master-server-"
}
variable "master_name" {
  //default="terraform-master-server-"
}
variable "worker_name" {
  //default="terraform-worker-server-"
}

variable "ip_range_network" {
  #default = "10.3.0.0/16"
}

variable "ip_range_subnet_hccm" {
  #default = "10.3.128.0/17"
}
