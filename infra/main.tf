provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-db"
  location = "East US"
}

resource "azurerm_sql_server" "sqlserver" {
  name                         = "sqlserverdemo"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "adminuser"
  administrator_login_password = "StrongP@ss123"
}

resource "azurerm_sql_database" "sqldb" {
  name                = "mydb"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sqlserver.name
  sku_name            = "S0"
}