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

  network_rules {
    default_action             = "Deny"
    ip_rules                   = []
    virtual_network_subnet_ids = [azurerm_subnet.private_endpoint_subnet.id]
    bypass                     = ["AzureServices"]
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [data.azurerm_resource_group.group]
}

resource "azurerm_storage_container" "tempdata" {
  count                 = var.deploy_temp_data_storage_account ? 1 : 0
  name                  = "tempdata"
  storage_account_name  = resource.azurerm_storage_account.tempdata[0].name
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
    private_connection_resource_id = resource.azurerm_storage_account.tempdata[0].id
    is_manual_connection           = false
    subresource_names              = ["blob"]
  }
}
