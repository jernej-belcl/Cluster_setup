#declare value of your token here or in terraform.tfvars
variable "hcloud_token" {
  # default = <your-api-token>
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

variable "location" {
  default = "nbg1"
}

variable "all_roles_instances" {
  type = number
  default = 1
}

variable "master_instances" {
  type = number
  //default = 4
}


variable "worker_instances" {
  type = number
  //default = 4
}

variable "server_type" {
  default = "ccx13"
}

variable "os_type" {
  default = "ubuntu-22.04"
}

variable "disk_size" {
  default = "20"
}

variable "ip_range_network" {
  #default = "10.3.0.0/16"
}

variable "ip_range_subnet_hccm" {
  #default = "10.3.128.0/17"
}

variable "cluster_token" {
  #Get by Export in create_cluster.sh
}

variable "load-balancer-name" {
  default = "lb-terraform"
}

variable "load-balancer-type" {
  default = "lb11"
}

variable "ssh_private_key_path" {
}
variable "ssh_public_key_path" {
}