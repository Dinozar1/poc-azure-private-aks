resource "azurerm_kubernetes_cluster" "aks_cluster" {
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.rg_name

  # must be unique in region
  dns_prefix = var.aks_dns_prefix



  default_node_pool {
    name                   = var.aks_default_pool_name
    node_count             = var.aks_default_node_count
    vm_size                = var.aks_default_vm_size
    vnet_subnet_id         = var.aks_subnet_id
    node_public_ip_enabled = false

    # need temporary for rotations of default values
    temporary_name_for_rotation = var.aks_rotation_name
  }

  identity {
    type = "SystemAssigned"
  }

  private_cluster_enabled             = true
  private_cluster_public_fqdn_enabled = false
  private_dns_zone_id                 = "System"

  # RBAC configuration
  local_account_disabled = true

  azure_active_directory_role_based_access_control {
    azure_rbac_enabled = true
    tenant_id          = var.aks_admin_tenant_id
  }

  network_profile {
    network_plugin = "azure"
  }

  lifecycle {
    ignore_changes = [
      default_node_pool[0].upgrade_settings
    ]
  }
}

resource "azurerm_role_assignment" "aks_rbac_admin" {
  scope                = azurerm_kubernetes_cluster.aks_cluster.id
  role_definition_name = "Azure Kubernetes Service RBAC Cluster Admin"
  principal_id         = var.aks_admin_principal_id
}

resource "azurerm_role_assignment" "aks_network_contributor" {
  scope                = var.aks_subnet_id
  role_definition_name = "Network Contributor"
  principal_id         = azurerm_kubernetes_cluster.aks_cluster.identity[0].principal_id
}