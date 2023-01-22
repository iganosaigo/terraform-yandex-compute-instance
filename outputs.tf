output "compute_instance" {
  value = yandex_compute_instance.this
}

output "compute_disks" {
  description = "Secondary disks of the instance"
  value       = yandex_compute_disk.this[*]
}

