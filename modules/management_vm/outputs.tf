output "public_ip" {
  value = azurerm_public_ip.management_vm_public_ip.ip_address
}

output "vm_principal_id" {
  value = azurerm_linux_virtual_machine.management_vm.identity[0].principal_id
}