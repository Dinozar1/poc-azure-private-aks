
variable "sa_name" {
  description = "Name of the storage account."
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

variable "share_name" {
  description = "Name of nfs."
  type        = string
  default     = "nfs-share"
}

variable "vnet_id" {
  description = "Id of working vnet."
  type        = string
}

variable "subnet_id" {
  description = "Id of working subnet."
  type        = string
}

variable "endpoint_name" {
  description = "Name of the endpoint."
  type        = string
  default     = "poc-storage-pe-001"
}

variable "private_service_connection_name" {
  type    = string
  default = "poc-storage-psc-001"
}
