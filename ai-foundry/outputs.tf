output "resource_group_name" {
  description = "Name of the resource group containing the Foundry resources."
  value       = azurerm_resource_group.foundry.name
}

output "foundry_account_id" {
  description = "Resource ID of the Foundry account."
  value       = azapi_resource.foundry_account.id
}

output "foundry_account_name" {
  description = "Name of the Foundry account."
  value       = azapi_resource.foundry_account.name
}

output "foundry_account_endpoint" {
  description = "Endpoint of the Foundry account."
  value       = azapi_resource.foundry_account.output.properties.endpoint
}

output "foundry_project_id" {
  description = "Resource ID of the Foundry project."
  value       = azapi_resource.foundry_project.id
}

output "foundry_project_principal_id" {
  description = "Principal ID of the Foundry project's system-assigned managed identity."
  value       = azapi_resource.foundry_project.output.identity.principalId
}

output "model_deployment_id" {
  description = "Resource ID of the optional model deployment, or null when disabled."
  value       = try(azapi_resource.model_deployment[0].id, null)
}