resource "random_string" "suffix" {
  length  = 6
  special = false
  upper   = false
}

resource "azurerm_mysql_flexible_server" "db" {
  name                   = "epic-db-${random_string.suffix.result}"
  resource_group_name    = var.resource_group_name
  location               = var.location
  administrator_login    = "epicadmin"
  administrator_password = var.db_password
  
  # Dev/Test friendly settings
  sku_name   = "B_Standard_B1ms" # Burstable (Cheapest)
  version    = "8.0.21"
  
  # This tells Azure not to worry about high availability/multiple zones
  zone       = "1" 
  
  storage {
    size_gb = 20 # Minimum size to keep costs low
  }
}

resource "azurerm_mysql_flexible_server_firewall_rule" "all" {
  name                = "AllowAll"
  server_name         = azurerm_mysql_flexible_server.db.name
  resource_group_name = var.resource_group_name
  start_ip_address    = "0.0.0.0"
  end_ip_address      = "255.255.255.255"
}