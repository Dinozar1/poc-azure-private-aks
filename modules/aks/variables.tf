variable "aks_name" {
  description = "Name of the Azure Kubernetes Service cluster."
  type        = string
}

variable "location" {
  description = "Azure region where the AKS cluster will be deployed."
  type        = string
  default     = "polandcentral"
}

variable "rg_name" {
  description = "Name of the resource group where the AKS cluster will be created."
  type        = string
}

variable "aks_dns_prefix" {
  description = "DNS prefix used for the AKS API server FQDN. Must be unique in the Azure region."
  type        = string
}

variable "aks_subnet_id" {
  description = "ID of the subnet where AKS node pool will be deployed. In this project it should be the snet-aks subnet ID."
  type        = string
}

variable "aks_default_pool_name" {
  description = "Name of the default AKS node pool. Must be lowercase alphanumeric and short. For AKS node pools, keep it <= 12 characters."
  type        = string
  default     = "system"
}

variable "aks_default_node_count" {
  description = "Initial number of nodes in the default AKS node pool. For POC, 1 node is enough to reduce cost."
  type        = number
  default     = 1
}

variable "aks_default_vm_size" {
  description = "VM size used by the default AKS node pool. Standard_B2s is a reasonable low-cost POC size."
  type        = string
  default     = "Standard_B2s"
}

variable "aks_rotation_name" {
  description = "Temporary node pool name used by AKS during default node pool rotation when changing immutable node pool properties."
  type        = string
  default     = "tempsystem"
}

variable "aks_admin_principal_id" {
  description = "Object ID of the user, group, service principal, or managed identity that should receive AKS RBAC Cluster Admin role."
  type        = string
}

variable "aks_admin_tenant_id" {
  description = "Tenant ID of the user, group, service principal, or managed identity that should receive AKS RBAC Cluster Admin role."
  type        = string
}