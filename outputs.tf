output "private_ips" {
  description = "VM ip addresses"
  value       = module.vm.private_ips
}
output "disk_ids" {
  description = "Extra disk ids"
  value       = module.data.disk_ids
}
