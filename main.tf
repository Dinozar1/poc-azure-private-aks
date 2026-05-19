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


data "azurerm_client_config" "current" {}

module "aks" {
  source = "./modules/aks"

  rg_name  = module.resource_group.name
  location = module.resource_group.location

  aks_subnet_id = module.network.aks_subnet_id

  aks_admin_principal_id = data.azurerm_client_config.current.object_id
  aks_admin_tenant_id    = data.azurerm_client_config.current.tenant_id

  aks_name               = var.aks_name
  aks_dns_prefix         = var.aks_dns_prefix
  aks_default_pool_name  = var.aks_default_pool_name
  aks_default_node_count = var.aks_default_node_count
  aks_default_vm_size    = var.aks_default_vm_size
  aks_rotation_name      = var.aks_rotation_name
}