variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "db_name" {
  type = string
}

variable "db_version" {
  type = string
}

variable "db_sku" {
  type = string
}

variable "db_storage_mb" {
  type = number
}

variable "db_admin_user" {
  default = "dbadmin8365"
}

variable "db_admin_password" {
  default = "Humber@26"
}
