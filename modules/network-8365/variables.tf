variable "rg_name" {
  type = string
}

variable "location" {
  type = string
}

variable "tags" {
  type = map(string)
}

variable "vnet_name" {
  type = string
}

variable "vnet_space" {
  type = list(string)
}

variable "subnet_name" {
  type = string
}

variable "subnet_space" {
  type = list(string)
}

variable "nsg_name" {
  type = string
}
