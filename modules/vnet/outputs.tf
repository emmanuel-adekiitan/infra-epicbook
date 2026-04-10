output "vnet_name"          { value = azurerm_virtual_network.main.name }
output "frontend_subnet_id" { value = azurerm_subnet.frontend.id }
output "backend_subnet_id"  { value = azurerm_subnet.backend.id }