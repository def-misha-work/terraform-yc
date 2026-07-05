output "disk_ids" {
  description = "Extra disk ids"
  value = {
    for idx, disk in yandex_compute_disk.extra_disks :
    var.extra_disk_names[idx] => disk.id
  }
}
output "subnet_id" {
  value = data.yandex_vpc_subnet.default_subnet.id
}
