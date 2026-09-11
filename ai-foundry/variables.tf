
variable "resource_group_name" {
  description = "Name of the resource group for the Foundry resources."
  type        = string
  default     = "rg-ai-foundry"
}

variable "location" {
  description = "Azure region for the Foundry resources and model deployment."
  type        = string
  default     = "polandcentral"
}

variable "name_prefix" {
  description = "Lowercase prefix used to name the globally unique Foundry account."
  type        = string
  default     = "aifoundry"

  validation {
    condition     = can(regex("^[a-z0-9][a-z0-9-]{1,40}[a-z0-9]$", var.name_prefix))
    error_message = "name_prefix must be 3-42 lowercase letters, numbers, or hyphens and cannot end with a hyphen."
  }
}

variable "project_name" {
  description = "Name of the Foundry project."
  type        = string
  default     = "default-project"

  validation {
    condition     = can(regex("^[a-zA-Z0-9][a-zA-Z0-9_.-]{1,63}$", var.project_name))
    error_message = "project_name must be 2-64 letters, numbers, periods, underscores, or hyphens."
  }
}

variable "principal_id" {
  description = "Optional Entra object ID to grant the Azure AI Developer role on the Foundry account."
  type        = string
  default     = null
  nullable    = true
}

variable "public_network_access_enabled" {
  description = "Allow public network access to the Foundry account."
  type        = bool
  default     = true
}

variable "deploy_model" {
  description = "Deploy a model to the Foundry account. Verify regional quota before enabling."
  type        = bool
  default     = true
}

variable "model_deployment_name" {
  description = "Name exposed to applications for the optional model deployment."
  type        = string
  default     = "gpt-4o-mini"
}

variable "model_name" {
  description = "Model catalog name for the optional deployment."
  type        = string
  default     = "gpt-4o-mini"
}

variable "model_version" {
  description = "Model version for the optional deployment."
  type        = string
  default     = "2024-07-18"
}

variable "model_sku_name" {
  description = "SKU for the optional model deployment."
  type        = string
  default     = "GlobalStandard"
}

variable "model_capacity" {
  description = "Capacity in thousands of tokens per minute for the optional model deployment."
  type        = number
  default     = 10

  validation {
    condition     = var.model_capacity > 0
    error_message = "model_capacity must be greater than zero."
  }
}

variable "tags" {
  description = "Tags applied to all supported resources."
  type        = map(string)
  default = {
    IaC      = "Terraform"
    Workload = "AI-Foundry"
  }
}