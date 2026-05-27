resource "azurerm_container_registry" "acr" {
  name                = var.acr_name
  resource_group_name = module.rg.name
  location            = module.rg.location
  sku                 = "Basic"
  admin_enabled       = false
  tags                = var.tags
}
