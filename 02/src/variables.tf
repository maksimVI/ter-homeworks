###cloud vars


variable "cloud_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/cloud/get-id"
}

variable "folder_id" {
  type        = string
  description = "https://cloud.yandex.ru/docs/resource-manager/operations/folder/get-id"
}


variable "default_zone" {
  type        = string
  default     = "ru-central1-a"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}
variable "default_cidr" {
  type        = list(string)
  default     = ["10.0.1.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name" {
  type        = string
  default     = "develop"
  description = "VPC network & subnet name"
}


variable "default_zone_db" {
  type        = string
  default     = "ru-central1-b"
  description = "https://cloud.yandex.ru/docs/overview/concepts/geo-scope"
}

variable "default_cidr_db" {
  type        = list(string)
  default     = ["10.0.2.0/24"]
  description = "https://cloud.yandex.ru/docs/vpc/operations/subnet-create"
}

variable "vpc_name_db" {
  type        = string
  default     = "develop_db"
  description = "VPC network & subnet name"
}


###ssh vars

# Удалить, т.к. приватный ключ указывать не нужно
# variable "vms_ssh_root_key" {
#   type        = string
#   default     = "~/.ssh/id_ed25519"
#   description = "ssh-keygen -t ed25519"
# }

# На задание 6 больше не используется, ключ в terraform.tfvars > vms_metadata = {
#variable "vms_ssh_public_root_key" {
#  type        = string
#  default     = "~/.ssh/id_ed25519.pub"
#  description = "ssh-keygen -t ed25519"
#}

variable "test" {
  type = list(map(list(string)))
}
