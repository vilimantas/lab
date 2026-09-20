# variable "subscription_id" {
# 	type        = string
# 	description = "Azure subscription ID used by the provider."
# }

variable "resource_group_name" {
  type        = string
  description = "Name of the resource group that contains the AKS cluster."
  default     = "rg-aks-cluster"
}

variable "location" {
  type        = string
  description = "Azure region for the AKS cluster."
  default     = "polandcentral"
}

variable "aks_cluster_name" {
  type        = string
  description = "Name of the AKS cluster."
  default     = "aks-cluster"
}

variable "system_node_pool_name" {
  type        = string
  description = "Name of the system node pool."
  default     = "system"
}

variable "system_node_count" {
  type        = number
  description = "Number of nodes in the system node pool."
  default     = 1
}

variable "system_node_vm_size" {
  type        = string
  description = "VM size used by the system node pool."
  default     = "Standard_D2ls_v5"
}

variable "system_node_os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB for each system node."
  default     = 60
}

variable "system_node_os_disk_type" {
  type        = string
  description = "OS disk type used by the system node pool."
  default     = "Managed"

  validation {
    condition     = contains(["Ephemeral", "Managed"], var.system_node_os_disk_type)
    error_message = "system_node_os_disk_type must be Ephemeral or Managed."
  }
}

variable "user_node_pool_name" {
  type        = string
  description = "Name of the user node pool."
  default     = "user"
}

variable "user_node_count" {
  type        = number
  description = "Number of nodes in the user node pool."
  default     = 1
}

variable "user_node_vm_size" {
  type        = string
  description = "VM size used by the user node pool."
  default     = "Standard_D2ls_v5"
}

variable "user_node_os_disk_size_gb" {
  type        = number
  description = "OS disk size in GB for each user node."
  default     = 60
}

variable "user_node_os_disk_type" {
  type        = string
  description = "OS disk type used by the user node pool."
  default     = "Managed"

  validation {
    condition     = contains(["Ephemeral", "Managed"], var.user_node_os_disk_type)
    error_message = "user_node_os_disk_type must be Ephemeral or Managed."
  }
}

variable "user_object_id" {
  type        = string
  description = "Microsoft Entra user object ID assigned AKS RBAC Cluster Admin."
  sensitive   = true
  default     = "8cf7c4ed-b729-4b1c-b979-a6ce52e53d5b"

}

variable "deploy_monitoring" {
  default     = false
  type        = bool
  description = "Enable Container Insights and managed Prometheus metrics on the cluster."

}

variable "log_analytics_workspace_id" {
  type        = string
  description = "Log Analytics workspace resource ID. Required when deploy_monitoring is true."
  default     = null

  validation {
    condition     = !var.deploy_monitoring || var.log_analytics_workspace_id != null
    error_message = "log_analytics_workspace_id must be set when deploy_monitoring is true."
  }
}

variable "tags" {
  type        = map(string)
  description = "Tags applied to the resource group and AKS cluster."
  default = {
    IaC = "Terraform"
  }
}
