module "rg" {
  source = "./modules/rg"

  name     = var.resource_group_name
  location = var.resource_group_location
}
