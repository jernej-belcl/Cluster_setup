resource "null_resource" "set_kernel_parameters_all_roles" {
  count = length(hcloud_server.all_roles_master)

  provisioner "file" {
    source      = "Hetzner_node_setup/scripts/set_kernel_params.sh"
    destination = "set_kernel_params.sh"
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
      "chmod +x set_kernel_params.sh",
      "./set_kernel_params.sh",
    ]
  }
  depends_on = [
    time_sleep.wait_10_seconds_after_all_roles_master_registration
    //null_resource.all_roles_master_registration
  ]
}


resource "null_resource" "set_kernel_parameters_master" {
  count = length(hcloud_server.master)

  provisioner "file" {
    source      = "Hetzner_node_setup/scripts/set_kernel_params.sh"
    destination = "set_kernel_params.sh"
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.master[count.index].ipv4_address
    }
  }

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.master[count.index].ipv4_address
    }
    inline = [
      // https://docs.rke2.io/security/hardening_guide
      "chmod +x set_kernel_params.sh",
      "./set_kernel_params.sh",
    ]
  }
  depends_on = [
    time_sleep.wait_3min_for_hetzner_allrolesmaster_sync,
    //time_sleep.wait_5s_to_initialize_master,
    null_resource.master_registration,
  ]
}


resource "null_resource" "set_kernel_parameters_worker" {
  count = length(hcloud_server.worker)

  provisioner "file" {
    source      = "Hetzner_node_setup/scripts/set_kernel_params.sh"
    destination = "set_kernel_params.sh"
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.worker[count.index].ipv4_address
    }
  }

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
        host        = hcloud_server.worker[count.index].ipv4_address
    }
    inline = [
      // https://docs.rke2.io/security/hardening_guide
      "chmod +x set_kernel_params.sh",
      "./set_kernel_params.sh",
    ]
  }
  depends_on = [
    time_sleep.wait_3min_for_hetzner_masternode_sync,
    null_resource.worker_registration,
    //time_sleep.wait_5s_to_prepare_master

  ]
}