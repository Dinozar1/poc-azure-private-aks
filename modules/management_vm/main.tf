resource "azurerm_public_ip" "management_vm_public_ip" {
  name                = var.public_ip_name
  location            = var.location
  resource_group_name = var.resource_group_name
  allocation_method   = "Static"
  sku                 = "Standard"
}

resource "azurerm_network_interface" "management_vm_nic" {
  name                = var.nic_name
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "primary"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.management_vm_public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "management_vm_nic_nsg_association" {
  network_interface_id      = azurerm_network_interface.management_vm_nic.id
  network_security_group_id = var.nsg_id
}

resource "azurerm_linux_virtual_machine" "management_vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username = var.admin_username

  network_interface_ids = [
    azurerm_network_interface.management_vm_nic.id
  ]

  admin_ssh_key {
    username   = var.admin_username
    public_key = var.ssh_public_key
  }

  identity {
    type = "SystemAssigned"
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = var.os_disk_storage_account_type
  }

  source_image_reference {
    publisher = var.source_image_publisher
    offer     = var.source_image_offer
    sku       = var.source_image_sku
    version   = var.source_image_version
  }

  custom_data = base64encode(templatefile("${path.module}/cloud-init.yaml", {
    resource_group_name = var.resource_group_name
    aks_cluster_name    = var.cluster_name
  }))

  tags = var.tags
}