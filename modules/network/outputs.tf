output "vnet_id" {
  value = azurerm_virtual_network.this.id
}

output "vnet_name" {
  value = azurerm_virtual_network.this.name
}

output "management_subnet_id" {
  value = azurerm_subnet.management.id
}

output "management_subnet_name" {
  value = azurerm_subnet.management.name
}

output "aks_subnet_id" {
  value = azurerm_subnet.aks.id
}

output "aks_subnet_name" {
  value = azurerm_subnet.aks.name
}

output "management_nsg_id" {
  value = azurerm_network_security_group.management.id
}

output "aks_nsg_id" {
  value = azurerm_network_security_group.aks.id
}