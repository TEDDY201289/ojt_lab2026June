output "resource_group_name" {
  description = "Resource group name from local child module."
  value       = module.rg.name
}

output "resource_group_id" {
  description = "Resource group ID from local child module."
  value       = module.rg.id
}

output "vnet_id" {
  description = "VNet ID from remote published module."
  value       = module.vnet.resource_id
}

output "subnet_ids" {
  description = "Subnet IDs from remote published module."
  value = {
    for subnet_key, subnet_value in module.vnet.subnets :
    subnet_key => subnet_value.resource_id
  }
}

output "acr_login_server" {
  description = "ACR login server."
  value       = azurerm_container_registry.acr.login_server
}

output "vm_private_ip" {
  description = "VM private IP address."
  value       = azurerm_network_interface.vm.private_ip_address
}
