variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "vnet_name" {
  description = "Virtual network name."
  type        = string
}

variable "vnet_address_space" {
  description = "VNet address space."
  type        = list(string)
}

variable "management_subnet_name" {
  description = "Management subnet name."
  type        = string
}

variable "management_subnet_address_prefixes" {
  description = "Management subnet address prefixes."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "AKS subnet name."
  type        = string
}

variable "aks_subnet_address_prefixes" {
  description = "AKS subnet address prefixes."
  type        = list(string)
}

variable "management_nsg_name" {
  description = "Management subnet NSG name."
  type        = string
}

variable "aks_nsg_name" {
  description = "AKS subnet NSG name."
  type        = string
}

variable "admin_public_ip_cidr" {
  description = "Admin public IP in CIDR format."
  type        = string
}

variable "management_allowed_ports" {
  description = "Allowed inbound ports to management subnet."
  type        = list(number)
  default     = [22]
}

variable "tags" {
  description = "Tags."
  type        = map(string)
  default     = {}
}