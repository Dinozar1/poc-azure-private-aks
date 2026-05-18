
variable "subscription_id" {
  type = string
}

variable "location" {
  description = "Azure region."
  type        = string
  default     = "polandcentral"
}

variable "resource_group_name" {
  description = "Resource group name."
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
  default     = "snet-management"
}

variable "management_subnet_address_prefixes" {
  description = "Management subnet address prefixes."
  type        = list(string)
}

variable "aks_subnet_name" {
  description = "AKS subnet name."
  type        = string
  default     = "snet-aks"
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
  description = "Your public IP in CIDR format, e.g. 1.2.3.4/32."
  type        = string
}

variable "management_allowed_ports" {
  description = "Allowed inbound ports to management subnet from admin_public_ip_cidr."
  type        = list(number)
  default     = [22]
}

variable "management_vm_name" {
  description = "Management VM name."
  type        = string
}

variable "management_vm_nic_name" {
  description = "Management VM NIC name."
  type        = string
}

variable "management_vm_public_ip_name" {
  description = "Management VM public IP resource name."
  type        = string
}

variable "management_vm_admin_username" {
  description = "Admin username for management VM."
  type        = string
  default     = "azureuser"
}

variable "management_vm_ssh_public_key" {
  description = "SSH public key contents for management VM."
  type        = string
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}