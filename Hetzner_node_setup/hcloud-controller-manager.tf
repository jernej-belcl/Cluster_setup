resource "null_resource" "install_hccm_on_all_roles_master" {
  depends_on = [
    time_sleep.wait_60_seconds_after_all_roles_master_registration
  ]
  count = length(hcloud_server.all_roles_master)

  provisioner "remote-exec" { //Passphrase needs to be removed for you ssh key
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.all_roles_master[count.index].ipv4_address
    }

    inline = [
      // Kubectl install
      "curl -LO https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl",
      "sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl",
      // Helm install
      "curl https://baltocdn.com/helm/signing.asc | gpg --dearmor | sudo tee /usr/share/keyrings/helm.gpg > /dev/null",
      "sudo apt-get install apt-transport-https --yes",
      "echo deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/helm.gpg] https://baltocdn.com/helm/stable/debian/ all main | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list",
      "sudo apt-get update",
      "sudo apt-get install helm",
      // Hetzner Cloud controller Manager
      "helm --kubeconfig /etc/rancher/rke2/rke2.yaml repo add hcloud https://charts.hetzner.cloud",
      "kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml -n kube-system create secret generic hcloud --from-literal=token=${var.hcloud_token} --from-literal=network=${hcloud_network.hcloud_private_network.id}",
      "helm --kubeconfig /etc/rancher/rke2/rke2.yaml install hccm hcloud/hcloud-cloud-controller-manager -n kube-system --set networking.enabled=true --set networking.clusterCIDR=${var.ip_range_subnet_hccm}",
      "kubectl --kubeconfig /etc/rancher/rke2/rke2.yaml apply -f https://raw.githubusercontent.com/hetznercloud/csi-driver/v2.5.1/deploy/kubernetes/hcloud-csi.yml",
    ]
  }
}