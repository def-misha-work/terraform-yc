terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100"
    }
  }
}
resource "yandex_compute_instance" "api" {
  name = "${var.name}-${var.name_prefix}-api-${var.environment}"
  resources {
    cores  = var.vm_specification["api"].cores
    memory = var.vm_specification["api"].memory
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_specification["api"].boot_disk
      size     = var.vm_specification["api"].disk_size
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = false
  }
  metadata = {
    ssh-keys = local.common_metadata
  }
  allow_stopping_for_update = true
}

resource "yandex_compute_instance" "web" {
  name = "${var.name}-${var.name_prefix}-web-${var.environment}"
  resources {
    cores  = var.vm_specification["web"].cores
    memory = var.vm_specification["web"].memory
  }
  scheduling_policy {
    preemptible = true
  }
  boot_disk {
    initialize_params {
      image_id = var.vm_specification["web"].boot_disk
      size     = var.vm_specification["web"].disk_size
    }
  }
  network_interface {
    subnet_id = var.subnet_id
    nat       = false
  }
  metadata = {
    ssh-keys = local.common_metadata
  }
  allow_stopping_for_update = true
}
