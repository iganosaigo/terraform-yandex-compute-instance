module "compute" {
  source         = "github.com/iganosaigo/terraform-yandex-compute-instance.git"
  name           = "test-ec"
  subnet_id      = module.vpc.subnets.subnet-a.id
  zone           = module.vpc.subnets.subnet-a.zone
  enable_nat     = true
  nat_ip_address = yandex_vpc_address.public.external_ipv4_address[0].address
  preemptible    = true

  allow_stopping_for_update = true
  serial_port_enable        = true
  user_data                 = data.cloudinit_config.configs.rendered

  cores         = 2
  memory        = 2
  core_fraction = 20

  secondary_disks = {
    "disk01" = { device_name = "storage_disk1" },
    "disk02" = {
      auto_delete = true,
      device_name = "storage_disk2",
      size        = 20
    }
  }
}

