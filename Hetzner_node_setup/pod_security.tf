/*resource "null_resource" "set_pod_security_all_roles" {
  count = length(hcloud_server.all_roles_master)

  provisioner "file" {
    source      = "Hetzner_node_setup/rancher-psact.yaml"
    destination = "/etc/rancher/rke2/rancher-psact.yaml"
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.all_roles_master[count.index].ipv4_address
    }
  }

  provisioner "file" {
    source      = "Hetzner_node_setup/scripts/pod_security.sh"
    destination = "pod_security.sh"
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.all_roles_master[count.index].ipv4_address
    }
  }

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.all_roles_master[count.index].ipv4_address
    }
    inline = [
      // https://docs.rke2.io/security/hardening_guide
      "chmod +x pod_security.sh",
      "./pod_security.sh",
    ]
  }
  depends_on = [
    null_resource.set_kernel_parameters_all_roles
  ]
}*/
