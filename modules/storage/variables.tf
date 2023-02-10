variable "resource_group_name" {
  type = string
}

variable "location" {
  type = string
}

variable "storage_account_name" {
  type = string
}

variable "is_grs" {
  type        = bool
  default     = false
  description = "Flag to enable Geo-redundancy"
}