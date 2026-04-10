provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "epic" {
  name     = var.rg_name
  location = var.location
}

module "vnet" {
  source              = "./modules/vnet"
  resource_group_name = azurerm_resource_group.epic.name
  location            = azurerm_resource_group.epic.location
}

module "nsg" {
  source              = "./modules/nsg"
  resource_group_name = azurerm_resource_group.epic.name
  location            = azurerm_resource_group.epic.location
}

module "database" {
  source              = "./modules/database"
  resource_group_name = azurerm_resource_group.epic.name
  location            = azurerm_resource_group.epic.location
  db_password         = var.db_password
}

module "compute" {
  source              = "./modules/compute"
  resource_group_name = azurerm_resource_group.epic.name
  location            = azurerm_resource_group.epic.location
  vnet_name           = module.vnet.vnet_name
  frontend_subnet_id  = module.vnet.frontend_subnet_id
  backend_subnet_id   = module.vnet.backend_subnet_id
  frontend_nsg_id     = module.nsg.nsg_id
  ssh_public_key      = var.SSH_PUBLIC_KEY
}