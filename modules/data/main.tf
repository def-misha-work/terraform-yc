terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100"
    }
  }
}
data "yandex_vpc_subnet" "default_subnet" {
  name = "default-${var.zone}"
}
resource "yandex_compute_disk" "extra_disks" {
  count       = length(var.extra_disk_names)
  description = "Extra data"
  name        = "${var.name_prefix}-${var.environment}-${var.extra_disk_names[count.index]}"
  type        = var.extra_disk_type
  zone        = var.zone
  size        = var.extra_disk_size
}
