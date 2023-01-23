output "compute_instance" {
  value = yandex_compute_instance.this
}

output "compute_disks" {
  description = "Secondary disks of the instance with device_name info"
  value = (
    { for name, value in var.secondary_disks :
      name => merge(
        { "device_name" = value.device_name },
        yandex_compute_disk.this[name]
      )
    }
  )
}

