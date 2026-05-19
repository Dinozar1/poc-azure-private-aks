
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


variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}

variable "aks_name" {
  description = "Name of the Azure Kubernetes Service private cluster."
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix for the AKS cluster. Must be unique in the Azure region."
  type        = string
}

variable "aks_default_pool_name" {
  description = "Name of the default AKS node pool. Must be lowercase, alphanumeric, and short."
  type        = string
  default     = "system"
}

variable "aks_default_node_count" {
  description = "Number of nodes in the default AKS node pool. For POC, 1 node is enough to reduce cost."
  type        = number
  default     = 1
}

variable "aks_default_vm_size" {
  description = "VM size for the default AKS node pool."
  type        = string
  default     = "Standard_B2s"
}

variable "aks_rotation_name" {
  description = "Temporary node pool name used by AKS during default node pool rotation."
  type        = string
  default     = "tempsystem"
}

