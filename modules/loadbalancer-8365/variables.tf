variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "lb_name" {
  type = string
}

variable "lb_sku" {
  type = string
}

variable "nic_ids" {
  type = map(string)
}
