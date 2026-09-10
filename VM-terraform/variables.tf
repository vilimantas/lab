variable "resource_group_location" {
  default     = "polandcentral"
  description = "Location of the resource group."
}

variable "subscription_id" {
  type        = string
  default     = "dcb8d7f2-aa48-4304-b2d9-b26fe84f2dc7"
  description = "Azure subscription id to deploy into (pinned explicitly to avoid CLI auto-detection issues)."
}

variable "prefix" {
  type        = string
  default     = "win-vm-iis"
  description = "Prefix of the resource name"
}

variable "storage_account_name" {
  type        = string
  default     = "sastatevlab2026"
  description = "Name of the storage account for the backend."
}

variable "storage_account_name_rg_name" {
  type        = string
  default     = "tfstate-rg"
  description = "Name of the resource group for the storage account backend."
}

variable "existing_vnet_resource_group_name" {
  type        = string
  default     = "rg-vnet-spoke"
  description = "Name of the resource group containing the existing vnet (deployed via bicep)."
}

variable "existing_vnet_name" {
  type        = string
  default     = "vnet-spoke"
  description = "Name of the existing vnet (deployed via bicep) to attach the new subnet and VM to."
}

variable "subnet_address_prefix" {
  type        = string
  default     = "10.0.3.0/24"
  description = "Address prefix for the new subnet created for this VM (must not overlap existing subnets, e.g. 10.0.1.0/24)."
}

variable "admin_username" {
  type        = string
  default     = "azureadmin"
  description = "VM admin username for test deployments."
}

variable "admin_password" {
  type        = string
  default     = "P@ssw0rd1234!"
  sensitive   = true
  description = "VM admin password for test deployments."
}