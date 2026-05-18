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

module "management_vm" {
  source = "./modules/management_vm"

  vm_name        = var.management_vm_name
  nic_name       = var.management_vm_nic_name
  public_ip_name = var.management_vm_public_ip_name

  location            = module.resource_group.location
  resource_group_name = module.resource_group.name

  subnet_id = module.network.management_subnet_id

  # NSG is covering to allow only admin ip address
  nsg_id = module.network.management_nsg_id

  admin_username = var.management_vm_admin_username
  ssh_public_key = var.management_vm_ssh_public_key

  tags = var.tags
}