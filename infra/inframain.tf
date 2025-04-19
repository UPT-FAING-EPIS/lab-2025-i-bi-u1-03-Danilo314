provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-sql-demo"
  location = "East US"
}

resource "azurerm_sql_server" "sql_server" {
  name                         = "sqlserverdemo123"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "YourP@ssw0rd123" # Usa variables seguras en producción
}

resource "azurerm_sql_database" "sql_db" {
  name                = "demo-db"
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  server_name         = azurerm_sql_server.sql_server.name
  sku_name            = "Basic"
}

output "sql_server_name" {
  value = azurerm_sql_server.sql_server.name
}

output "sql_db_name" {
  value = azurerm_sql_database.sql_db.name
}