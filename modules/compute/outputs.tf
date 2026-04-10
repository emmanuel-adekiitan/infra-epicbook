output "frontend_public_ip" {
  description = "The public IP address of the frontend VM"
  value       = azurerm_public_ip.pip.ip_address
}

output "backend_private_ip" {
  description = "The private IP address of the backend VM"
  # Assuming you create a second VM named 'backend' in your compute main.tf
  value       = azurerm_linux_virtual_machine.backend.private_ip_address
}

output "frontend_vm_id" {
  value = azurerm_linux_virtual_machine.frontend.id
}