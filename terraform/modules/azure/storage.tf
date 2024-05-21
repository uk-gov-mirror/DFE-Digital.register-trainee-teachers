resource "azurerm_storage_account" "tempdata" {
  count                           = 1
  name                            = var.tempdata_storage_account_name
  resource_group_name             = var.backend_resource_group_name
  location                        = var.region_name
  account_replication_type        = var.storage_account_replication_type
  account_tier                    = "Standard"
  allow_nested_items_to_be_public = false

  blob_properties {
    delete_retention_policy {
      days = 7
    }
    container_delete_retention_policy {
      days = 7
    }
  }

  # network_rules {
  #   default_action             = "Deny"
  #   ip_rules                   = []
  #   virtual_network_subnet_ids = [azurerm_subnet.private_endpoint_subnet.id]
  # }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [data.azurerm_resource_group.group]
}

resource "azurerm_storage_container" "tempdata" {
  count                 = var.deploy_temp_data_storage_account ? 1 : 0
  name                  = "tempdata"
  storage_account_name  = azurerm_storage_account.tempdata[0].name
  container_access_type = "private"
}
# to be created by TSC
resource "azurerm_subnet" "private_endpoint_subnet" {
  name                 = "privateEndpointSubnet"
  resource_group_name  = var.backend_resource_group_name
  virtual_network_name = var.virtual_network_name
  address_prefixes     = ["10.0.1.0/24"]
}

resource "azurerm_private_endpoint" "storage_private_endpoint" {
  name                = "tempdata-storage-private-endpoint"
  location            = var.region_name
  resource_group_name = var.backend_resource_group_name
  subnet_id           = azurerm_subnet.private_endpoint_subnet.id

  private_service_connection {
    name                           = "tempdata-storage-private-service-connection"
    private_connection_resource_id = azurerm_storage_account.tempdata[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}

resource "azurerm_private_dns_zone" "privatelink_blob" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.backend_resource_group_name
}

resource "azurerm_private_dns_zone_virtual_network_link" "privatelink_blob_vnet" {
  name                  = "privatelink-blob-vnet-link"
  resource_group_name   = var.backend_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.privatelink_blob.name
  virtual_network_id    = azurerm_virtual_network.main.id
}

resource "azurerm_private_dns_a_record" "tempdata" {
  name                = azurerm_storage_account.tempdata[0].primary_blob_endpoint
  zone_name           = azurerm_private_dns_zone.privatelink_blob.name
  resource_group_name = var.backend_resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.storage_private_endpoint.private_service_connection[0].private_ip_address]
}
