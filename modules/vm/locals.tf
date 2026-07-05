locals {
  ssh_public_key  = var.ssh_public_key != null ? var.ssh_public_key : file("~/.ssh/id_rsa.pub")
  common_metadata = "${var.ssh_username}:${local.ssh_public_key}"
}
