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

variable "windows_name" {
  type = string
}

variable "avset_name" {
  type = string
}

variable "nb_count" {
  type = number
}

variable "windows_admin_user" {
  default = "n10038365"
}

variable "windows_admin_password" {
  default = "Humber@26"
}
