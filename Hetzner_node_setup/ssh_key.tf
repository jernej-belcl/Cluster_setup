resource "hcloud_ssh_key" "jb-ssh-key" {
  name       = "hetzner__jb_ssh_key"
  public_key = file(var.ssh_public_key_path)
}