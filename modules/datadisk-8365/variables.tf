variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "linux_vm_ids" {
  type = map(string)
}

variable "linux_zones" {
  type = map(string)
}

variable "windows_vm_ids" {
  type = list(string)
}

variable "windows_names" {
  type = list(string)
}

variable "disk_size" {
  type = number
}
