resource "null_resource" "all_roles_master_registration" {
  count = length(hcloud_server.all_roles_master)

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.all_roles_master[count.index].ipv4_address
    }
    inline = [
      //Registration
      "curl -fL https://clusters.kale.izi.bi/system-agent-install.sh | sudo  sh -s - --server https://clusters.kale.izi.bi --label 'cattle.io/os=linux' --token ${var.cluster_token} --etcd --controlplane --worker --address ${hcloud_server.all_roles_master[count.index].ipv4_address} --internal-address ${hcloud_server.all_roles_master[count.index].network.*.ip[0]} --node-name ${hcloud_server.all_roles_master[count.index].name}",
    ]
  }
  depends_on = [
    hcloud_server.all_roles_master
  ]
}


resource "null_resource" "master_registration" {
  count = length(hcloud_server.master)

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.master[count.index].ipv4_address
    }

    inline = [
      //Registration
      "curl -fL https://clusters.kale.izi.bi/system-agent-install.sh | sudo  sh -s - --server https://clusters.kale.izi.bi --label 'cattle.io/os=linux' --token ${var.cluster_token} --etcd --controlplane --address ${hcloud_server.master[count.index].ipv4_address} --internal-address ${hcloud_server.master[count.index].network.*.ip[0]} --node-name ${hcloud_server.master[count.index].name}",
      "sleep 180"
    ]
  }
  depends_on = [
    hcloud_server.master,
    time_sleep.wait_60_seconds_after_all_roles_master_registration
  ]
}

resource "null_resource" "worker_registration" {
  count = length(hcloud_server.worker)

  provisioner "remote-exec" { //Remove passphrase
    connection {
      type        = "ssh"
      user        = "root"
      private_key = file(var.ssh_private_key_path)
      host        = hcloud_server.worker[count.index].ipv4_address
    }

    inline = [
      //Registration
      "curl -fL https://clusters.kale.izi.bi/system-agent-install.sh | sudo  sh -s - --server https://clusters.kale.izi.bi --label 'cattle.io/os=linux' --token ${var.cluster_token} --worker --address ${hcloud_server.worker[count.index].ipv4_address} --internal-address ${hcloud_server.worker[count.index].network.*.ip[0]} --node-name ${hcloud_server.worker[count.index].name}",
      "sleep 180"
    ]
  }
  depends_on = [
    hcloud_server.worker
  ]
}