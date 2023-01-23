data "yandex_compute_image" "this" {
  family = var.image_family
}

locals {
  serial_port_enable = var.serial_port_enable ? 1 : null
  use_snapshot       = var.image_snapshot_id != null ? true : false
  image_id = (
    coalesce(
      var.image_id,
      data.yandex_compute_image.this.id
  ))
}

resource "yandex_compute_disk" "this" {
  for_each = var.secondary_disks

  folder_id  = var.folder_id
  zone       = var.zone
  name       = "${var.name}-${each.key}"
  type       = each.value.type
  size       = each.value.size
  block_size = each.value.block_size
  labels     = each.value.labels
}

resource "yandex_compute_instance" "this" {
  name               = var.name
  folder_id          = var.folder_id
  platform_id        = var.platform_id
  zone               = var.zone
  description        = var.description
  hostname           = var.hostname
  service_account_id = var.service_account_id
  labels             = var.labels

  allow_stopping_for_update = var.allow_stopping_for_update
  network_acceleration_type = var.network_acceleration_type

  scheduling_policy {
    preemptible = var.preemptible
  }

  resources {
    cores         = var.cores
    memory        = var.memory
    core_fraction = var.core_fraction
  }

  boot_disk {
    auto_delete = var.boot_disk.auto_delete
    device_name = var.boot_disk.device_name
    mode        = var.boot_disk.mode

    initialize_params {
      name        = "${var.name}-boot-disk"
      size        = var.boot_disk_initialize_params.size
      block_size  = var.boot_disk_initialize_params.block_size
      type        = var.boot_disk_initialize_params.type
      image_id    = local.use_snapshot ? null : local.image_id
      snapshot_id = local.use_snapshot ? var.image_snapshot_id : null
    }
  }

  network_interface {
    subnet_id          = var.subnet_id
    nat                = var.enable_nat
    nat_ip_address     = var.nat_ip_address
    ip_address         = var.internal_ip_address
    security_group_ids = var.security_group_ids
    #dns_record {}
    #nat_dns_record {}
  }

  dynamic "secondary_disk" {
    for_each = (
      { for disk_name, disk_info in yandex_compute_disk.this :
      disk_name => merge(disk_info, var.secondary_disks[disk_name]) }
    )

    iterator = disk
    content {
      auto_delete = disk.value.auto_delete
      disk_id     = disk.value.id
      mode        = disk.value.mode
      device_name = disk.value.device_name
    }
  }

  metadata = {
    serial-port-enable = local.serial_port_enable
    ssh-keys           = "${var.ssh_user}:${file(var.ssh_pubkey)}"
    user-data          = var.user_data
  }

  lifecycle {
    ignore_changes = [boot_disk, metadata["user-data"]]
  }
}

