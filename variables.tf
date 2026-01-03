#------------------------
# Network Security Group
#------------------------
variable "name" {
  description = "(Required) Specifies the name of the network security group. Changing this forces a new resource to be created."
  type        = string
}

variable "resource_group_name" {
  description = "(Required) The name of the resource group in which to create the network security group. Changing this forces a new resource to be created."
  type        = string
}

variable "location" {
  description = "(Required) Specifies the supported Azure location where the resource exists. Changing this forces a new resource to be created."
  type        = string
}

variable "tags" {
  description = "(Optional) A mapping of tags to assign to the resource."
  type        = map(any)
  default     = {}
}

variable "inbound_rules" {
  description = "List of inbound network security rules"
  type        = any
  default     = []
}

variable "outbound_rules" {
  description = "List of inbound outbound security rules"
  type        = any
  default     = []
}

#------------------------
# Subnet NSG Association
#------------------------
variable "subnet_id" {
  description = "(Required) The ID of the Subnet. Changing this forces a new resource to be created."
  type        = string
}