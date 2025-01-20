# Public IP and DNS info
output "public_ip_address" {
  value = azurerm_public_ip.my_public_ip.ip_address
  description = "The public IP address of the VM"
}

output "fqdn" {
  value = format("http://%s", azurerm_public_ip.my_public_ip.fqdn)
  description = "The FQDN of the VM"
}

# SSH connection string
output "ssh_command" {
  value = "ssh adminuser@${azurerm_public_ip.my_public_ip.ip_address} -i private_key.openssh"
  description = "Command to SSH into the VM"
}

# Resource group info
output "resource_group_name" {
  value = azurerm_resource_group.my_rg.name
  description = "The name of the resource group"
}
