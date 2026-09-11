resource "random_string" "account_suffix" {
  length  = 8
  special = false
  upper   = false
}

resource "azurerm_resource_group" "foundry" {
  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

resource "azapi_resource" "foundry_account" {
  type      = "Microsoft.CognitiveServices/accounts@2025-06-01"
  parent_id = azurerm_resource_group.foundry.id
  name      = "${var.name_prefix}-${random_string.account_suffix.result}"
  location  = azurerm_resource_group.foundry.location
  tags      = var.tags

  identity {
    type = "SystemAssigned"
  }

  body = {
    kind = "AIServices"
    sku = {
      name = "S0"
    }
    properties = {
      allowProjectManagement = true
      customSubDomainName    = "${var.name_prefix}-${random_string.account_suffix.result}"
      disableLocalAuth       = true
      publicNetworkAccess    = var.public_network_access_enabled ? "Enabled" : "Disabled"
      networkAcls = {
        defaultAction = var.public_network_access_enabled ? "Allow" : "Deny"
      }
    }
  }

  response_export_values = ["properties.endpoint", "identity.principalId"]
}

resource "azapi_resource" "foundry_project" {
  type      = "Microsoft.CognitiveServices/accounts/projects@2025-06-01"
  parent_id = azapi_resource.foundry_account.id
  name      = var.project_name
  location  = azurerm_resource_group.foundry.location
  tags      = var.tags

  identity {
    type = "SystemAssigned"
  }

  body = {
    properties = {
      displayName = var.project_name
      description = "Microsoft Foundry project managed by Terraform"
    }
  }

  response_export_values = ["identity.principalId"]
}

resource "azurerm_role_assignment" "ai_developer" {
  count = var.principal_id == null ? 0 : 1

  scope                = azapi_resource.foundry_account.id
  role_definition_name = "Azure AI Developer"
  principal_id         = var.principal_id
}

resource "azapi_resource" "model_deployment" {
  count = var.deploy_model ? 1 : 0

  type      = "Microsoft.CognitiveServices/accounts/deployments@2025-06-01"
  parent_id = azapi_resource.foundry_account.id
  name      = var.model_deployment_name

  body = {
    sku = {
      name     = var.model_sku_name
      capacity = var.model_capacity
    }
    properties = {
      model = {
        format  = "OpenAI"
        name    = var.model_name
        version = var.model_version
      }
      versionUpgradeOption = "OnceNewDefaultVersionAvailable"
    }
  }
}