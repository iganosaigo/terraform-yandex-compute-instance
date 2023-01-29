output "compute_instance" {
  description = "Compute instance's data"
  value       = yandex_compute_instance.this
}

output "compute_disks" {
  description = "Secondary disk's data"
  value = (
    { for name, value in var.secondary_disks :
      name => merge(
        { "device_name" = value.device_name },
        yandex_compute_disk.this[name]
      )
    }
  )
}

