# Yandex.Cloud Terraform Compute Instance module
Provided as is. Make sure you check what it does before apply.
<!-- BEGIN_TF_DOCS -->

## Example

```hcl
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

```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3 |
| <a name="requirement_yandex"></a> [yandex](#requirement\_yandex) | 0.84.0 |

## Usage
Basic usage of this module is as follows:

```hcl
module "example" {
	 source  = "github.com/iganosaigo/terraform-yandex-compute-instance.git"

	 # Required variables
	 name  = 
	 subnet_id  = 

	 # Optional variables
	 allow_stopping_for_update  = false
	 boot_disk  = {}
	 boot_disk_initialize_params  = {}
	 core_fraction  = null
	 cores  = 2
	 description  = null
	 enable_nat  = null
	 folder_id  = null
	 hostname  = null
	 image_family  = "almalinux-8"
	 image_id  = null
	 image_snapshot_id  = null
	 internal_ip_address  = null
	 labels  = {}
	 memory  = 2
	 nat_ip_address  = null
	 network_acceleration_type  = null
	 platform_id  = "standard-v3"
	 preemptible  = false
	 secondary_disks  = {}
	 security_group_ids  = null
	 serial_port_enable  = false
	 service_account_id  = null
	 ssh_pubkey  = "~/.ssh/id_rsa.pub"
	 ssh_user  = "almalinux"
	 user_data  = null
	 zone  = null
}
```

## Resources

| Name | Type |
|------|------|
| [yandex_compute_disk.this](https://registry.terraform.io/providers/yandex-cloud/yandex/0.84.0/docs/resources/compute_disk) | resource |
| [yandex_compute_instance.this](https://registry.terraform.io/providers/yandex-cloud/yandex/0.84.0/docs/resources/compute_instance) | resource |
| [yandex_compute_image.this](https://registry.terraform.io/providers/yandex-cloud/yandex/0.84.0/docs/data-sources/compute_image) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_allow_stopping_for_update"></a> [allow\_stopping\_for\_update](#input\_allow\_stopping\_for\_update) | Allow stop the instance in order to update properties | `bool` | `false` | no |
| <a name="input_boot_disk"></a> [boot\_disk](#input\_boot\_disk) | Basic params of the boot disk | <pre>object({<br>    auto_delete = optional(bool)<br>    device_name = optional(string)<br>    mode        = optional(string)<br>  })</pre> | `{}` | no |
| <a name="input_boot_disk_initialize_params"></a> [boot\_disk\_initialize\_params](#input\_boot\_disk\_initialize\_params) | Additianl parameters of the boot disk | <pre>object({<br>    size       = optional(number)<br>    block_size = optional(number)<br>    type       = optional(string, "network-hdd")<br>  })</pre> | `{}` | no |
| <a name="input_core_fraction"></a> [core\_fraction](#input\_core\_fraction) | Core\_fraction applied to the instance | `number` | `null` | no |
| <a name="input_cores"></a> [cores](#input\_cores) | Cores allocated to the instance | `number` | `2` | no |
| <a name="input_description"></a> [description](#input\_description) | Description of the instance | `string` | `null` | no |
| <a name="input_enable_nat"></a> [enable\_nat](#input\_enable\_nat) | Enable public IPv4 address | `bool` | `null` | no |
| <a name="input_folder_id"></a> [folder\_id](#input\_folder\_id) | Folder ID | `string` | `null` | no |
| <a name="input_hostname"></a> [hostname](#input\_hostname) | Hostname of the instance | `string` | `null` | no |
| <a name="input_image_family"></a> [image\_family](#input\_image\_family) | Default Image family name. It's ID has lowest priority | `string` | `"almalinux-8"` | no |
| <a name="input_image_id"></a> [image\_id](#input\_image\_id) | Image ID. Has middle priority | `string` | `null` | no |
| <a name="input_image_snapshot_id"></a> [image\_snapshot\_id](#input\_image\_snapshot\_id) | Image snapshot id to initialize from.<br>Highest priority over var.image\_id<br>and var.image\_family" | `string` | `null` | no |
| <a name="input_internal_ip_address"></a> [internal\_ip\_address](#input\_internal\_ip\_address) | Private IPv4 allocated to the instance | `string` | `null` | no |
| <a name="input_labels"></a> [labels](#input\_labels) | A set of labels of the instance | `map(string)` | `{}` | no |
| <a name="input_memory"></a> [memory](#input\_memory) | Memory allocated to the instance(in Gb) | `number` | `2` | no |
| <a name="input_name"></a> [name](#input\_name) | Name for the resource | `string` | n/a | yes |
| <a name="input_nat_ip_address"></a> [nat\_ip\_address](#input\_nat\_ip\_address) | Public IPv4 allocated to the address | `string` | `null` | no |
| <a name="input_network_acceleration_type"></a> [network\_acceleration\_type](#input\_network\_acceleration\_type) | Network acceleration type | `string` | `null` | no |
| <a name="input_platform_id"></a> [platform\_id](#input\_platform\_id) | Hardware CPU platform name | `string` | `"standard-v3"` | no |
| <a name="input_preemptible"></a> [preemptible](#input\_preemptible) | Make instance preemptible | `bool` | `false` | no |
| <a name="input_secondary_disks"></a> [secondary\_disks](#input\_secondary\_disks) | Additional disks with params | <pre>map(object({<br>    # params for cumpute_instance secondary_disk<br>    auto_delete = optional(bool, false)<br>    mode        = optional(string)<br>    labels      = optional(map(string), {})<br><br>    # params for compute_disk resource<br>    type        = optional(string, "network-hdd")<br>    size        = optional(number, 10)<br>    block_size  = optional(number, 4096)<br>    device_name = optional(string)<br>  }))</pre> | `{}` | no |
| <a name="input_security_group_ids"></a> [security\_group\_ids](#input\_security\_group\_ids) | Security group IDs linked to the instance | `list(string)` | `null` | no |
| <a name="input_serial_port_enable"></a> [serial\_port\_enable](#input\_serial\_port\_enable) | Enable serial port on the instance | `bool` | `false` | no |
| <a name="input_service_account_id"></a> [service\_account\_id](#input\_service\_account\_id) | Service account ID for the instance | `string` | `null` | no |
| <a name="input_ssh_pubkey"></a> [ssh\_pubkey](#input\_ssh\_pubkey) | Public RSA key path to inject | `string` | `"~/.ssh/id_rsa.pub"` | no |
| <a name="input_ssh_user"></a> [ssh\_user](#input\_ssh\_user) | Initial account username for instance | `string` | `"almalinux"` | no |
| <a name="input_subnet_id"></a> [subnet\_id](#input\_subnet\_id) | VPC Subnet ID | `string` | n/a | yes |
| <a name="input_user_data"></a> [user\_data](#input\_user\_data) | Cloud-init user-data | `string` | `null` | no |
| <a name="input_zone"></a> [zone](#input\_zone) | Network Zone | `string` | `null` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_compute_disks"></a> [compute\_disks](#output\_compute\_disks) | Secondary disk's data |
| <a name="output_compute_instance"></a> [compute\_instance](#output\_compute\_instance) | Compute instance's data |
<!-- END_TF_DOCS -->


