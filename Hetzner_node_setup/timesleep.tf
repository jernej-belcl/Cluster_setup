resource "time_sleep" "wait_10_seconds_after_all_roles_master_registration" {
  depends_on = [null_resource.all_roles_master_registration]
  create_duration = "10s"
}

resource "time_sleep" "wait_60_seconds_after_all_roles_master_registration" {
  depends_on = [null_resource.set_kernel_parameters_all_roles]
  create_duration = "60s"
}

resource "time_sleep" "wait_3min_for_hetzner_allrolesmaster_sync" {
  depends_on = [
    null_resource.install_hccm_on_all_roles_master,
  ]
  create_duration = "3m" // smaller duration //waiting for cluster to connect
}

resource "time_sleep" "wait_3min_for_hetzner_masternode_sync" {
  depends_on = [time_sleep.wait_3min_for_hetzner_allrolesmaster_sync]
  create_duration = "3m" // smaller duration
}