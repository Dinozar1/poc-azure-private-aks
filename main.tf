module "resource_group" {
  source = "./modules/resource_group"

  name     = var.resource_group_name
  location = var.location
  tags     = var.tags
}

module "network" {
  source = "./modules/network"

  resource_group_name = module.resource_group.name
  location            = module.resource_group.location

  vnet_name          = var.vnet_name
  vnet_address_space = var.vnet_address_space

  management_subnet_name             = var.management_subnet_name
  management_subnet_address_prefixes = var.management_subnet_address_prefixes

  aks_subnet_name             = var.aks_subnet_name
  aks_subnet_address_prefixes = var.aks_subnet_address_prefixes

  management_nsg_name = var.management_nsg_name
  aks_nsg_name        = var.aks_nsg_name

  admin_public_ip_cidr     = var.admin_public_ip_cidr
  management_allowed_ports = var.management_allowed_ports

  tags = var.tags
}