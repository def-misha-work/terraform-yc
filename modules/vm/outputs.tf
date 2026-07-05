output "private_ips" {
  description = "VM ip addresses"
  value = {
    "api_vm" = yandex_compute_instance.api.network_interface[0].ip_address
    "web_vm" = yandex_compute_instance.web.network_interface[0].ip_address
  }
}
