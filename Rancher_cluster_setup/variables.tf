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

variable "ip_range_cilium_subnet" {
  #default = "10.3.0.0/17"
}

variable "kubeconfig_path" {
}


/*variable "wasabi_access_key" {
  # default = "<rancher2_access_key>"
}

variable "wasabi_secret_key" {
  # default = "<rancher2_secret_key"
}*/
