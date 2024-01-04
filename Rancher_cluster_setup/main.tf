# Create a new rancher v2 RKE2 custom Cluster v2
resource "rancher2_cluster_v2" "terraform_cluster" {
  name                  = var.cluster_name
  kubernetes_version    = var.rancher_kubernetes_version
  default_pod_security_admission_configuration_template_name = "rancher-privileged"
  enable_network_policy = true
  rke_config {

    machine_global_config = <<EOF
      cluster-cidr: ${var.ip_range_cilium_subnet}
      cni: cilium
      disable:
            - cloud-controller
            - rke2-ingress-nginx
      disable-kube-proxy: false
      etcd-expose-metrics: false
  EOF

    machine_selector_config {
      config = {
        cloud-provider-name     = "external"
        protect-kernel-defaults = true
        profile                 = "cis-1.23"
      }
    }
    upgrade_strategy {
      control_plane_concurrency = "1"
      control_plane_drain_options {
        delete_empty_dir_data = true
        enabled               = true
        force                 = true
        timeout               = 300
      }
      worker_concurrency = "1"
      worker_drain_options {
        delete_empty_dir_data = true
        enabled               = true
        force                 = true
        timeout               = 300
      }
    }
    chart_values = <<EOF
      rke2-cilium:
        ipv4NativeRoutingCIDR: ${var.ip_range_cilium_subnet}
        tunnel: disabled
EOF
  }
}