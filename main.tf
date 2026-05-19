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

resource "tls_private_key" "vm_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "local_sensitive_file" "vm_private_key" {
  content         = tls_private_key.vm_ssh_key.private_key_pem
  filename        = "${path.root}/managment-vm-key.pem"
  file_permission = "0600"
}

resource "local_file" "vm_public_key" {
  content  = tls_private_key.vm_ssh_key.public_key_openssh
  filename = "${path.root}/managment-vm-key.pem.pub"
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
  ssh_public_key = tls_private_key.vm_ssh_key.public_key_openssh

  cluster_name = module.aks.cluster_name

  tags = var.tags
}

resource "azurerm_role_assignment" "aks_rbac_vm_admin" {
  scope                = module.aks.cluster_id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = module.management_vm.vm_principal_id

  depends_on = [
    module.aks,
    module.management_vm
  ]
}