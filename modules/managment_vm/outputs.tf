output "public_ip" {
  value = azurerm_public_ip.management_vm_public_ip.ip_address
}