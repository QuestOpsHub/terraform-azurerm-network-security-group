#------------------------
# Network Security Group
#------------------------
output "id" {
  description = "Network Security Group ID"
  value       = azurerm_network_security_group.network_security_group.id
}

#---------------
# Inbound Rules
#---------------
output "inbound_rules" {
  description = "Inbound Rules"
  value       = azurerm_network_security_rule.inbound
}

#----------------
# Outbound Rules
#----------------
output "outbound_rules" {
  description = "Outbound Rules"
  value       = azurerm_network_security_rule.outbound
}