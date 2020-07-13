provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "dbaplicacao" {
  name     = "azaw"
  location = "EAST US"
}

resource "azurerm_mysql_server" "mysqlaplicacao" {
  name                = "mysqlaplicacao"
  location            = azurerm_resource_group.dbaplicacao.location
  resource_group_name = azurerm_resource_group.dbaplicacao.name

  administrator_login          = "aplicacaoadmin"
  administrator_login_password = "H!S&1DowE!"

  sku_name   = "B_Gen5_2"
  storage_mb = 5120
  version    = "5.7"

   auto_grow_enabled                 = true
  backup_retention_days             = 7
  geo_redundant_backup_enabled      = true
  infrastructure_encryption_enabled = true
  public_network_access_enabled     = false
  ssl_enforcement_enabled           = true
  ssl_minimal_tls_version_enforced  = "TLS1_2"
}

resource "azurerm_mysql_database" "mysql" {
  name                = "aplicacao"
  resource_group_name = azurerm_resource_group.dbaplicacao.name
  server_name         = azurerm_mysql_server.mysqlaplicacao.name
  charset             = "utf8"
  collation           = "utf8_unicode_ci"
}