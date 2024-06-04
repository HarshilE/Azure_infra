output "Pub_network_interface_ids" {
  description = "Output NIC ID"
  value = azurerm_network_interface.public_nic.id
}

output "Pvt_network_interface_ids" {
  description = "Output NIC ID"
  value = azurerm_network_interface.private_nic.id
}

output "azurerm_public_ip_test" {
  description = "Output public ip"
  value = azurerm_public_ip.test.id
}
