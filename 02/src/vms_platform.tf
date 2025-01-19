variable "vm_web_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image VM for web-platform" 
}

#variable "vm_web_name" {
#  type        = string
#  default     = "netology-develop-platform-web"
#  description = "Name VM for web-platform"
#}

variable "vm_web_name_env" {
  type        = string
  default     = "develop"
  description = "Env for name VM"
}

variable "vm_web_name_project" {
  type        = string
  default     = "platform"
  description = "Project for name VM"
}

variable "vm_web_name_role" {
  type        = string
  default     = "web"
  description = "Role for name VM"
}

variable "vm_web_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform VM for web-platform"
}


variable "vm_db_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image VM for db-platform" 
}

#variable "vm_db_name" {
#  type        = string
#  default     = "netology-develop-platform-db"
#  description = "Name VM for db-platform"
#}

variable "vm_db_name_env" {
  type        = string
  default     = "develop"
  description = "Env for name VM-db"
}

variable "vm_db_name_project" {
  type        = string
  default     = "platform"
  description = "Project for name VM-db"
}

variable "vm_db_name_role" {
  type        = string
  default     = "db"
  description = "Role for name VM-db"
}

variable "vm_db_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform VM for db-platform"
}

variable "vms_resources" {
  type = map(object({
    cores         = number
    memory        = number
    core_fraction = number
  }))
  description = "Resources for VMs"
}

variable "vms_metadata" {
  type = map(object({
    serial_port_enable  = number
    keys                = string
  }))
  description = "Metadata for VMs"
}