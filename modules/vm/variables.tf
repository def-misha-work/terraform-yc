# General
variable "zone" {
  type = string
}
variable "environment" {
  type = string
}

# This module
variable "vm_size" {
  type = string
}
variable "vm_specification" {
  type = map(object({
    cores     = number
    memory    = number
    disk_size = number
    boot_disk = string
  }))
}
variable "ssh_username" {
  type = string
}
variable "ssh_public_key" {
  type = string
}
variable "name" {
  type = string
}
variable "name_prefix" {
  type = string
}
variable "subnet_id" {
  type = string
}
