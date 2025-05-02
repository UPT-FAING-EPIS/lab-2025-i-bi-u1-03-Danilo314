provider "azurerm" {
  features {
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }

  subscription_id = var.subscription_id
  client_id       = var.client_id
  client_secret   = var.client_secret
  tenant_id       = var.tenant_id
}

resource "azurerm_resource_group" "danilo_rg" {
  name     = "danilo-rg"
  location = "West US 2"
}

resource "azurerm_mssql_server" "danilo_sql_server" {
  name                         = "danilo-sqlserver"
  resource_group_name          = azurerm_resource_group.danilo_rg.name
  location                     = azurerm_resource_group.danilo_rg.location
  version                      = "12.0"
  administrator_login          = var.sqladmin_username
  administrator_login_password = var.sqladmin_password

  identity {
    type = "SystemAssigned"
  }
}

resource "azurerm_mssql_database" "danilo_database" {
  name                         = "danilo-db"
  server_id                    = azurerm_mssql_server.danilo_sql_server.id
  sku_name                     = "GP_S_Gen5_2"
  collation                    = "SQL_Latin1_General_CP1_CI_AS"
  auto_pause_delay_in_minutes = 60
  min_capacity                 = 0.5
  storage_account_type         = "Local"
}

resource "azurerm_mssql_firewall_rule" "allow_azure_services" {
  name             = "danilo-fw-allow-azure"
  server_id        = azurerm_mssql_server.danilo_sql_server.id
  start_ip_address = "0.0.0.0"
  end_ip_address   = "255.255.255.255"
}
