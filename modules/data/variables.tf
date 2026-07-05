# General
variable "zone" {
  type = string
}
variable "environment" {
  type = string
}
variable "name_prefix" {
  type = string
}

# This module
variable "extra_disk_names" {
  type = list(any)
}
variable "extra_disk_type" {
  type = string
}
variable "extra_disk_size" {
  type = number
}
