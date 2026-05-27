
variable "kv_name" {
  description = "Name of the key vault."
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

variable "tenant_id" {
  type = string
}

variable "admin_object_id" {
  type = string
}

variable "aks_identity_object_id" {
  type = string
}

variable "storage_account_key" {
  type      = string
  sensitive = true
}

variable "storage_key_name" {
  type    = string
  default = "storage_key"
}