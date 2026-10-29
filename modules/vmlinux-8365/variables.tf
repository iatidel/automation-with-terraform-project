variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "subnet_id" {
  type = string
}

variable "storage_uri" {
  type = string
}

variable "vm_size" {
  type = string
}

variable "admin_username" {
  type = string
}

variable "public_key_path" {
  type = string
}

variable "linux_vms" {
  description = "Map of VM name to availability zone"
  type        = map(string)
}

variable "private_key_path" {
  type = string
}
