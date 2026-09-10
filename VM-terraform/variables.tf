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
  default     = "test-vm"
  description = "Name of the resource group containing the existing vnet (deployed via bicep)."
}

variable "existing_vnet_name" {
  type        = string
  default     = "vnet-test-vm"
  description = "Name of the existing vnet (deployed via bicep) to attach the new subnet and VM to."
}

variable "subnet_address_prefix" {
  type        = string
  default     = "10.0.2.0/24"
  description = "Address prefix for the new subnet created for this VM (must not overlap existing subnets, e.g. 10.0.1.0/24)."
}

variable "existing_key_vault_name" {
  type        = string
  default     = "kv-shark-secrets"
  description = "Name of the existing Key Vault (deployed via bicep) that stores the VM admin credentials."
}

variable "existing_key_vault_resource_group_name" {
  type        = string
  default     = "kv-shark-secrets-rg"
  description = "Resource group of the existing Key Vault."
}

variable "admin_username_secret_name" {
  type        = string
  default     = "vm-admin-username"
  description = "Key Vault secret name for the VM admin username."
}

variable "admin_password_secret_name" {
  type        = string
  default     = "vm-admin-password"
  description = "Key Vault secret name for the VM admin password."
}