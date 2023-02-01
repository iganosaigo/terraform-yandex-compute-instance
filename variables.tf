variable "name" {
  description = "Name for the resource"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID"
  type        = string
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

variable "zone" {
  description = "Network Zone"
  type        = string
  default     = null
}

variable "platform_id" {
  description = "Hardware CPU platform name"
  type        = string
  default     = "standard-v3"
}

variable "description" {
  description = "Description of the instance"
  type        = string
  default     = null
}

variable "service_account_id" {
  description = "Service account ID for the instance"
  type        = string
  default     = null
}

variable "labels" {
  description = "A set of labels of the instance"
  type        = map(string)
  default     = {}
}

# https://cloud.yandex.ru/docs/compute/concepts/network#hostname
variable "hostname" {
  description = "Hostname of the instance"
  type        = string
  default     = null
}

variable "allow_stopping_for_update" {
  description = "Allow stop the instance in order to update properties"
  type        = bool
  default     = false
}

variable "network_acceleration_type" {
  description = "Network acceleration type"
  type        = string
  default     = null
}


variable "cores" {
  description = "Cores allocated to the instance"
  type        = number
  default     = 2
}


variable "memory" {
  description = "Memory allocated to the instance(in Gb)"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Core_fraction applied to the instance"
  type        = number
  default     = null
}

variable "image_snapshot_id" {
  description = <<-EOT
Image snapshot id to initialize from.
Highest priority over var.image_id
and var.image_family"
EOT
  type        = string
  default     = null

}

variable "image_id" {
  description = "Image ID. Has middle priority"
  type        = string
  default     = null
}

variable "image_family" {
  description = "Default Image family name. It's ID has lowest priority"
  type        = string
  default     = "almalinux-8"
}

variable "boot_disk" {
  description = "Basic params of the boot disk"
  type = object({
    auto_delete = optional(bool)
    device_name = optional(string)
    mode        = optional(string)
  })
  default = {}
}

variable "boot_disk_initialize_params" {
  description = "Additianl parameters of the boot disk"
  type = object({
    size       = optional(number)
    block_size = optional(number)
    type       = optional(string, "network-hdd")
  })
  default = {}
}

variable "ssh_user" {
  description = "Initial account username for instance"
  type        = string
  default     = "almalinux"
}

variable "ssh_pubkey" {
  description = "Public RSA key path to inject"
  type        = string
  default     = "~/.ssh/id_rsa.pub"
}

variable "user_data" {
  description = "Cloud-init user-data"
  type        = string
  default     = null
}

variable "internal_ip_address" {
  description = "Private IPv4 allocated to the instance"
  type        = string
  default     = null
}

variable "enable_nat" {
  description = "Enable public IPv4 address"
  type        = bool
  default     = null
}
variable "nat_ip_address" {
  description = "Public IPv4 allocated to the address"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "Security group IDs linked to the instance"
  type        = list(string)
  default     = null
}

variable "secondary_disks" {
  description = "Additional disks with params"
  type = map(object({
    # params for cumpute_instance secondary_disk
    auto_delete = optional(bool, false)
    mode        = optional(string)
    labels      = optional(map(string), {})

    # params for compute_disk resource
    type        = optional(string, "network-hdd")
    size        = optional(number, 10)
    block_size  = optional(number, 4096)
    device_name = optional(string)
  }))
  default = {}
}

variable "preemptible" {
  description = "Make instance preemptible"
  type        = bool
  default     = false
}

variable "serial_port_enable" {
  description = "Enable serial port on the instance"
  type        = bool
  default     = false
}
