resource "azurerm_storage_account" "storage_account" {
  name                = var.sa_name
  resource_group_name = var.rg_name
  location            = var.location

  account_tier             = "Standard"
  account_replication_type = "LRS"
  account_kind             = "StorageV2"

  public_network_access_enabled = false
}

resource "azurerm_storage_share" "storage_share" {
  name               = var.share_name
  storage_account_id = azurerm_storage_account.storage_account.id
  quota              = 50

}

resource "azurerm_private_dns_zone" "privite_dns" {
  name                = "privatelink.file.core.windows.net"
  resource_group_name = var.rg_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "dns_virt_link" {
  name                  = "${var.sa_name}-file-dns-link"
  resource_group_name   = var.rg_name
  private_dns_zone_name = azurerm_private_dns_zone.privite_dns.name
  virtual_network_id    = var.vnet_id
}

resource "azurerm_private_endpoint" "private_endpoint" {
  name                = var.endpoint_name
  location            = var.location
  resource_group_name = var.rg_name
  subnet_id           = var.subnet_id

  private_service_connection {
    name                           = var.private_service_connection_name
    private_connection_resource_id = azurerm_storage_account.storage_account.id
    subresource_names              = ["file"]
    is_manual_connection           = false
  }

  private_dns_zone_group {
    name = "default"

    private_dns_zone_ids = [
      azurerm_private_dns_zone.privite_dns.id
    ]
  }
}