terraform {
  required_version = ">= 1.5.0"

  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = ">= 0.100"
    }
  }
  backend "s3" {
    endpoint = "https://storage.yandexcloud.net"
    bucket   = "s5631315-terraform"
    region   = "ru-central1-a"

    skip_region_validation      = true
    skip_credentials_validation = true
    skip_requesting_account_id  = true
    skip_s3_checksum            = true
  }
}
provider "yandex" {
  zone = var.zone
}

module "vm" {
  source           = "./modules/vm"
  environment      = var.environment
  name             = var.name
  name_prefix      = var.name_prefix
  vm_size          = var.vm_size
  vm_specification = var.vm_specification
  ssh_username     = var.ssh_username
  ssh_public_key   = var.ssh_public_key
  zone             = var.zone
  subnet_id        = module.data.subnet_id
}
module "data" {
  source           = "./modules/data"
  name_prefix      = var.name_prefix
  environment      = var.environment
  extra_disk_names = var.extra_disk_names
  extra_disk_type  = var.extra_disk_type
  extra_disk_size  = var.extra_disk_size
  zone             = var.zone
}
