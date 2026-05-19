variable "vm_name" {
  description = "Management VM name."
  type        = string
}

variable "nic_name" {
  description = "Management VM NIC name."
  type        = string
}

variable "public_ip_name" {
  description = "Management VM public IP name."
  type        = string
}

variable "location" {
  description = "Azure region."
  type        = string
}

variable "resource_group_name" {
  description = "Resource group name."
  type        = string
}

variable "subnet_id" {
  description = "Subnet ID where management VM will be deployed."
  type        = string
}

variable "nsg_id" {
  description = "NSG ID attached to management VM NIC."
  type        = string
}

variable "admin_username" {
  description = "Admin username for the management VM."
  type        = string
}

variable "ssh_public_key" {
  description = "SSH public key for the management VM."
  type        = string
}

variable "vm_size" {
  description = "Azure VM size."
  type        = string
  default     = "Standard_B1s"
}

variable "os_disk_storage_account_type" {
  description = "Storage account type for OS disk."
  type        = string
  default     = "Standard_LRS"
}

variable "source_image_publisher" {
  description = "VM image publisher."
  type        = string
  default     = "Canonical"
}

variable "source_image_offer" {
  description = "VM image offer."
  type        = string
  default     = "0001-com-ubuntu-server-jammy"
}

variable "source_image_sku" {
  description = "VM image SKU."
  type        = string
  default     = "22_04-lts"
}

variable "source_image_version" {
  description = "VM image version."
  type        = string
  default     = "latest"
}

variable "tags" {
  description = "Common tags."
  type        = map(string)
  default     = {}
}

variable "cluster_name" {
  description = "name of aks cluster"
  type        = string
}