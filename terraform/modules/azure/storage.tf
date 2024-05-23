# Existing subnet data source
data "azurerm_subnet" "aks_network" {
  name                 = "aks-snet"
  virtual_network_name = "s189d01-tsc-cluster3-vnet"
  resource_group_name  = "s189d01-tsc-dv-rg"
}

# Existing storage account resource
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
    virtual_network_subnet_ids = [data.azurerm_subnet.aks_network.id]
  }

  lifecycle {
    ignore_changes = [tags]
  }

  depends_on = [data.azurerm_resource_group.group]
}

# New private DNS zone
resource "azurerm_private_dns_zone" "example" {
  name                = "privatelink.blob.core.windows.net"
  resource_group_name = var.backend_resource_group_name
}

# Link the private DNS zone to the virtual network
resource "azurerm_private_dns_zone_virtual_network_link" "example" {
  name                  = "example-link"
  resource_group_name   = var.backend_resource_group_name
  private_dns_zone_name = azurerm_private_dns_zone.example.name
  virtual_network_id    = data.azurerm_subnet.aks_network.virtual_network_name
}

# Create a private endpoint for the storage account
resource "azurerm_private_endpoint" "example" {
  name                = "example-private-endpoint"
  location            = var.region_name
  resource_group_name = var.backend_resource_group_name
  subnet_id           = data.azurerm_subnet.aks_network.id

  private_service_connection {
    name                           = "example-privatelink"
    private_connection_resource_id = azurerm_storage_account.tempdata.id
    subresource_names              = ["blob"]
    is_manual_connection           = false
  }

  depends_on = [azurerm_storage_account.tempdata]
}

# Create a DNS record for the private endpoint
resource "azurerm_private_dns_a_record" "example" {
  name                = "s189d01registervtmp"
  zone_name           = azurerm_private_dns_zone.example.name
  resource_group_name = var.backend_resource_group_name
  ttl                 = 300
  records             = [azurerm_private_endpoint.example.private_service_connection[0].private_ip_address]
}

# Output the private IP address of the private endpoint for verification
output "private_endpoint_ip" {
  value = azurerm_private_endpoint.example.private_service_connection[0].private_ip_address
}
