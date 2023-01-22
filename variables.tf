variable "name" {
  description = "Name for the resource"
  type        = string
}

variable "subnet_id" {
  description = "VPC Subnet ID"
  type        = string
  default     = null
}

variable "folder_id" {
  description = "Folder ID"
  type        = string
  default     = null
}

variable "zone" {
  description = "Zone for provision resources"
  type        = string
  default     = null
}


variable "image_id" {
  description = "Image ID"
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
  description = "A set of labels for the instance"
  type        = map(string)
  default     = {}
}

# https://cloud.yandex.ru/docs/compute/concepts/network#hostname
variable "hostname" {
  description = "Hostname for the instance"
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
  description = "Cores allocated for the instance"
  type        = number
  default     = 2
}


variable "memory" {
  description = "Memory allocated for the instance(in Gb)"
  type        = number
  default     = 2
}

variable "core_fraction" {
  description = "Core_fraction applied for the instance"
  type        = number
  default     = null
}


variable "boot_disk" {
  description = "Basic params for the boot_disk block."
  type = object({
    auto_delete = optional(bool)
    device_name = optional(string)
    mode        = optional(string)
  })
  default = {}
}

variable "image_snapshot_id" {
  description = <<-EOT
Image snapshot id to initialize from.
Highest priority over var.boot_disk_initialize_params.image_id
and var.image_family"
EOT
  type        = string
  default     = null

}

variable "boot_disk_initialize_params" {
  description = "Parameters for a new disk. image_id has middle priority."
  type = object({
    image_id   = optional(string)
    size       = optional(number)
    block_size = optional(number)
    type       = optional(string, "network-hdd")
  })
  default = {}
}

variable "image_family" {
  description = "Default Image family name. It's ID has lowest priority"
  type        = string
  default     = "almalinux-8"
}

variable "boot_user" {
  description = "Username for booted instance"
  type        = string
  default     = "almalinux"
}

variable "ssh_pubkey" {
  description = "Public RSA key to inject"
  type        = string
  default     = null
}

variable "user_data" {
  description = "Cloud-init user-data"
  type        = string
  default     = null
}

variable "internal_ip_address" {
  description = "Specify private IPv4 to instance"
  type        = string
  default     = null
}

variable "enable_nat" {
  description = "Enable public IPv4 address"
  type        = bool
  default     = null
}
variable "nat_ip_address" {
  description = "Specify public IPv4 address"
  type        = string
  default     = null
}

variable "security_group_ids" {
  description = "List of security group IDs"
  type        = list(string)
  default     = null
}

variable "secondary_disks" {
  description = "Additional disks with params"
  type = map(object({
    # params for cumpute_instance secondary_disk block
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
  description = "Enable serial port on instance"
  type        = bool
  default     = false
}
