#------------------------
# Network Security Group
#------------------------
resource "azurerm_network_security_group" "network_security_group" {
  name                = var.name
  resource_group_name = var.resource_group_name
  location            = var.location

  tags = var.tags
  lifecycle {
    ignore_changes = [
      tags["creation_timestamp"],
    ]
  }
}

#---------------
# Inbound Rules
#---------------
resource "azurerm_network_security_rule" "inbound" {
  for_each                                   = { for rule in var.inbound_rules : rule.name => rule }
  resource_group_name                        = azurerm_network_security_group.network_security_group.resource_group_name
  network_security_group_name                = azurerm_network_security_group.network_security_group.name
  direction                                  = "Inbound"
  name                                       = each.value.name
  priority                                   = each.value.priority
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_address_prefix                      = lookup(each.value, "source_address_prefix", null)
  source_address_prefixes                    = lookup(each.value, "source_address_prefixes", null)
  source_application_security_group_ids      = lookup(each.value, "source_application_security_group_ids", null)
  source_port_range                          = lookup(each.value, "source_port_range", null)
  source_port_ranges                         = lookup(each.value, "source_port_ranges", null)
  destination_address_prefix                 = lookup(each.value, "destination_address_prefix", null)
  destination_address_prefixes               = lookup(each.value, "destination_address_prefixes", null)
  destination_application_security_group_ids = lookup(each.value, "destination_application_security_group_ids", null)
  destination_port_range                     = lookup(each.value, "destination_port_range", null)
  destination_port_ranges                    = lookup(each.value, "destination_port_ranges", null)
  description                                = lookup(each.value, "description", null)
}

#----------------
# Outbound Rules
#----------------
resource "azurerm_network_security_rule" "outbound" {
  for_each                                   = { for rule in var.outbound_rules : rule.name => rule }
  resource_group_name                        = azurerm_network_security_group.network_security_group.resource_group_name
  network_security_group_name                = azurerm_network_security_group.network_security_group.name
  direction                                  = "Outbound"
  name                                       = each.value.name
  priority                                   = each.value.priority
  access                                     = each.value.access
  protocol                                   = each.value.protocol
  source_address_prefix                      = lookup(each.value, "source_address_prefix", null)
  source_address_prefixes                    = lookup(each.value, "source_address_prefixes", null)
  source_application_security_group_ids      = lookup(each.value, "source_application_security_group_ids", null)
  source_port_range                          = lookup(each.value, "source_port_range", null)
  source_port_ranges                         = lookup(each.value, "source_port_ranges", null)
  destination_address_prefix                 = lookup(each.value, "destination_address_prefix", null)
  destination_address_prefixes               = lookup(each.value, "destination_address_prefixes", null)
  destination_application_security_group_ids = lookup(each.value, "destination_application_security_group_ids", null)
  destination_port_range                     = lookup(each.value, "destination_port_range", null)
  destination_port_ranges                    = lookup(each.value, "destination_port_ranges", null)
  description                                = lookup(each.value, "description", null)
}

#------------------------
# Subnet NSG Association
#------------------------
resource "azurerm_subnet_network_security_group_association" "snet_nsg_association" {
  depends_on = [
    azurerm_network_security_rule.inbound,
    azurerm_network_security_rule.outbound
  ]
  subnet_id                 = var.subnet_id
  network_security_group_id = azurerm_network_security_group.network_security_group.id
}