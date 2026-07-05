# General variables.
variable "name_prefix" {
  description = "User name"
  type        = string
  default     = "s5631315"
}
variable "environment" {
  description = "Deployment environment: dev, prod"
  type        = string
  default     = "dev"
  validation {
    condition     = contains(["dev", "prod"], var.environment)
    error_message = "Available environments: dev, prod."
  }
}
variable "zone" {
  description = "Name of zone"
  type        = string
  default     = "ru-central1-a"
  validation {
    condition = contains([
      "ru-central1-a"
      ], var.zone
    )
    error_message = "Available zone: ru-central1-a."
  }
}

# Variables for module data.
variable "extra_disk_names" {
  description = "List disks for VM"
  type        = list(any)
  default     = ["logs", "backup"]
  validation {
    condition = alltrue([
      for name in var.extra_disk_names :
      contains(["logs", "backup"], name)
    ])
    error_message = "Available options: logs, backup."
  }
}
variable "extra_disk_type" {
  description = "Disk type"
  type        = string
  default     = "network-hdd"
  validation {
    condition = contains([
      "network-hdd", "network-ssd"
      ], var.extra_disk_type
    )
    error_message = "Available options: logs, backup."
  }
}
variable "extra_disk_size" {
  description = "Extra disk size"
  type        = number
  default     = 30
  validation {
    condition     = var.extra_disk_size >= 30 && var.extra_disk_size <= 1000
    error_message = "The extra disk size must be between 30 and 1000 GB."
  }
}

# Variables for module VM.
variable "name" {
  description = "Name of VM"
  type        = string
  default     = "vm-default-name"
}
variable "vm_size" {
  description = "Size disks"
  default     = 20
  type        = number
  validation {
    condition     = var.vm_size > 1 && var.vm_size <= 1000
    error_message = "The disk size must be between 1 and 1000 GB."
  }
}
variable "vm_specification" {
  type = map(object({
    cores     = number
    memory    = number
    disk_size = number
    boot_disk = string
  }))
  default = {
    web = {
      cores     = 2
      memory    = 2
      disk_size = 20
      boot_disk = "fd845dr9j4h2aaq1m6ko"
    },
    api = {
      cores     = 2
      memory    = 2
      disk_size = 20
      boot_disk = "fd845dr9j4h2aaq1m6ko"
    }
  }
  validation {
    condition = alltrue([
      for spec in values(var.vm_specification) :
      contains([
        { cores = 2, memory = 2 },
        { cores = 2, memory = 4 },
      ], { cores = spec.cores, memory = spec.memory })
    ])
    error_message = "Acceptable options: 2×2, 2×4."
  }
}
variable "ssh_username" {
  description = "Username for SSH access."
  type        = string
  default     = "ubuntu"
}
variable "ssh_public_key" {
  description = "Content of the SSH public key."
  type        = string
  default     = null
  sensitive   = true
}
