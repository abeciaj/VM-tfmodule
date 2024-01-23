variable "rg_name" {
  type        = string
  description = "Existing Resource Group Name"
}

variable "rg_location" {
  type        = string
  description = "Resource Group Location"
}

variable "project_name" {
  type        = string
  description = "Resource Name"
}

variable "instance_number" {
  type        = string
  description = "Resource number"
  default     = "01"
}

variable "address_space" {
  type        = list(any)
  description = "Address Space"
  default     = ["10.0.0.0/16"]
}

variable "address_prefixes" {
  type        = list(any)
  description = "Address Prefix"
  default     = ["10.0.2.0/24"]
}

variable "vm_size" {
  type        = string
  description = "VM Size"
  default     = "Standard_D2s_v3"
}

variable "admin_username" {
  type        = string
  description = "Admin Username"
  default     = "adminuser"
}

variable "admin_password" {
  type        = string
  description = "Admin Password"
  default     = "Default_P@ssw0rd123"
}