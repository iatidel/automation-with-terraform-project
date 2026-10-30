variable "humber_id" {
  type    = string
  default = "8365"
}

variable "location" {
  type    = string
  default = "eastus"
}

variable "db_location" {
  type    = string
  default = "canadacentral"
}

variable "vnet_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}

variable "subnet_space" {
  type    = list(string)
  default = ["10.0.0.0/24"]
}

variable "linux_vm_size" {
  type    = string
  default = "Standard_D2as_v4"
}

variable "windows_vm_size" {
  type    = string
  default = "Standard_D2as_v4"
}

variable "admin_username" {
  type    = string
  default = "n10038365"
}

variable "public_key_path" {
  type    = string
  default = "/home/n10038365/.ssh/id_rsa.pub"
}

variable "private_key_path" {
  type    = string
  default = "/home/n10038365/.ssh/id_rsa"
}

variable "linux_vms" {
  type = map(string)
  default = {
    "8365-u-vm1" = "1"
    "8365-u-vm2" = "2"
    "8365-u-vm3" = "3"
  }
}

variable "windows_count" {
  type    = number
  default = 1
}

variable "disk_size" {
  type    = number
  default = 10
}

variable "lb_sku" {
  type    = string
  default = "Standard"
}

variable "db_version" {
  type    = string
  default = "12"
}

variable "db_sku" {
  type    = string
  default = "B_Standard_B1ms"
}

variable "db_storage_mb" {
  type    = number
  default = 32768
}
