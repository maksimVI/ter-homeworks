variable "vm_image" {
  type        = string
  default     = "ubuntu-2004-lts"
  description = "Image VM for platform" 
}

variable "vm_platform" {
  type        = string
  default     = "standard-v1"
  description = "Platform VM for platforms"
}

variable "vms_resources" {
  type = object({
    cores         = number
    memory        = number
    core_fraction = number
  })
  description = "Resources for VMs"
}

variable "each_vm" {
  type = list(object({  vm_name=string, cpu=number, ram=number, disk_volume=number, core_fraction=number }))
}