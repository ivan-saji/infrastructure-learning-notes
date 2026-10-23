#Mention the sql server resources here

resource "azurerm_mssql_server" "sql01" {
  name                         = "sql01-sqldb"
  resource_group_name          = azurerm_resource_group.rg01.name
  location                     = azurerm_resource_group.rg01.location
  version                      = "12.0"
  administrator_login          = "sqladmin"
  administrator_login_password = "P@ssword1234"
  minimum_tls_version          = "1.2"
}

#Mention the database

resource "azurerm_mssql_database" "db01" {
  name      = "db01-sqldb"
  server_id = azurerm_mssql_server.sql01.id
  collation = "SQL_Latin1_General_CP1_CI_AS"
  sku_name  = "S0"
}

#Mention the firewall rules
resource "azurerm_mssql_firewall_rule" "fw01" {
  name                = "fw01-sqldb"
  server_id           = azurerm_mssql_server.sql01.id
  start_ip_address    = "49.37.233.60"
  end_ip_address      = "49.37.233.60"
}