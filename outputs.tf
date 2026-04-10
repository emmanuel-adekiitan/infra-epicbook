output "FRONTEND_PUBLIC_IP" { value = module.compute.frontend_public_ip }
output "BACKEND_PRIVATE_IP" { value = module.compute.backend_private_ip }
output "MYSQL_HOST"         { value = module.database.mysql_fqdn }