provider "azurerm" {
  features {}
  subscription_id = "f7782463-8cd3-492c-b5fa-57ef6878a5fa"
}

resource "azurerm_resource_group" "rg" {
  name     = "rg-sql-demo"
  location = "West US 2"
}

resource "azurerm_mssql_server" "sqlserver" {
  name                         = "sqlserverdemotf"
  resource_group_name          = azurerm_resource_group.rg.name
  location                     = azurerm_resource_group.rg.location
  version                      = "12.0"
  administrator_login          = "sqladminuser"
  administrator_login_password = "P@ssword1234!" # ⚠️ Asegúrate de que cumpla las políticas de seguridad
}

resource "azurerm_mssql_database" "sqldb" {
  name           = "mi-sql-db"
  server_id      = azurerm_mssql_server.sqlserver.id
  sku_name       = "Basic"

  tags = {
    environment = "dev"
  }
}