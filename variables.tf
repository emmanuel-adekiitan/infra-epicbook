variable "rg_name" { default = "rg-epicbook-prod" }
variable "location" { default = "West US 2" }
variable "db_password" { sensitive = true }
variable "SSH_PUBLIC_KEY" { type = string }