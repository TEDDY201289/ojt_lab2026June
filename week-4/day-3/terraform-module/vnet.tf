module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.17.1"

  name             = var.vnet_name
  location         = module.rg.location
  parent_id        = module.rg.id
  address_space    = var.vnet_address_space
  subnets          = var.subnets
  enable_telemetry = false
  tags             = var.tags
}
