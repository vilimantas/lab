data "azurerm_client_config" "current" {}

resource "azurerm_resource_group" "aks" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                          = var.aks_cluster_name
  location                      = azurerm_resource_group.aks.location
  resource_group_name           = azurerm_resource_group.aks.name
  dns_prefix                    = var.aks_cluster_name
  sku_tier                      = "Standard"
  role_based_access_control_enabled = true
  local_account_disabled             = true
  tags                               = var.tags

  default_node_pool {
    name            = var.system_node_pool_name
    node_count      = var.system_node_count
    vm_size         = var.system_node_vm_size
    os_disk_size_gb = var.system_node_os_disk_size_gb
    os_disk_type    = var.system_node_os_disk_type
    os_sku          = "AzureLinux"
    zones           = ["1", "2", "3"]
  }

  identity {
    type = "SystemAssigned"
  }

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = data.azurerm_client_config.current.tenant_id
  }

  network_profile {
    network_plugin = "azure"
    outbound_type  = "managedNATGateway"
  }

  key_vault_secrets_provider {
    secret_rotation_enabled = true
  }

  dynamic "oms_agent" {
    for_each = var.deploy_monitoring ? [1] : []
    content {
      log_analytics_workspace_id = var.log_analytics_workspace_id
    }
  }

  dynamic "monitor_metrics" {
    for_each = var.deploy_monitoring ? [1] : []
    content {
      annotations_allowed = "*"
      labels_allowed      = "*"
    }
  }
}

resource "azurerm_role_assignment" "cluster_admin" {
  scope                = azurerm_kubernetes_cluster.aks.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.user_object_id
  principal_type       = "User"
}