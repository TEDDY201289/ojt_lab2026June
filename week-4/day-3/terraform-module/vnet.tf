module "vnet" {
  source  = "Azure/avm-res-network-virtualnetwork/azurerm"
  version = "0.17.1"

  name          = "module-lab-vnet"
  location      = module.rg.location
  parent_id     = module.rg.id
  address_space = ["10.0.0.0/16"]

  subnets = {
    public = {
      name             = "public-subnet"
      address_prefixes = ["10.0.1.0/24"]
    }

    private = {
      name             = "private-subnet"
      address_prefixes = ["10.0.2.0/24"]
    }
  }
}