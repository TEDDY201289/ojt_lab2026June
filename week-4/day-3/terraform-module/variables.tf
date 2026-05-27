variable "location" {
  description = "Azure region."
  type        = string
  default     = "southeastasia"
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
  default     = "rg-module-demo"
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
  default     = "vnet-module-demo"
}

variable "vnet_address_space" {
  description = "VNet address space."
  type        = list(string)
  default     = ["10.10.0.0/16"]
}

variable "subnets" {
  description = "Subnets for the VNet module."
  type = map(object({
    name             = string
    address_prefixes = list(string)
  }))

  default = {
    app = {
      name             = "snet-app"
      address_prefixes = ["10.10.1.0/24"]
    }

    db = {
      name             = "snet-db"
      address_prefixes = ["10.10.2.0/24"]
    }
  }
}

variable "acr_name" {
  description = "Azure Container Registry name. Must be globally unique."
  type        = string
  default     = "learndevopsacr01"
}

variable "vm_name" {
  description = "Virtual machine name."
  type        = string
  default     = "vm-module-demo"
}

variable "vm_admin_username" {
  description = "VM admin username."
  type        = string
  default     = "azureuser"
}

variable "vm_ssh_public_key" {
  description = "SSH public key for VM login."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)

  default = {
    project = "terraform-module-demo"
    owner   = "learn-devops-now"
  }
}
